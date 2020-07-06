Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61BD2215B66
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jul 2020 18:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbgGFQGF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jul 2020 12:06:05 -0400
Received: from sonic313-20.consmr.mail.ir2.yahoo.com ([77.238.179.187]:39547
        "EHLO sonic313-20.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729293AbgGFQGF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jul 2020 12:06:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1594051563; bh=DPYuw2gUpgtMJzJhlH/AVmRGu2wSKCY1C+f8nOCoxu0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=UwRvVSKUHTV1m76iVZRDI83kRgTV6JAQcMaYIiLSqAzsB6RdgmU/xNYqdlHcfgRmd04egxBnllBgIj+rGXJXd5bx1be7bUPy6kbcVP22t5jbjpAiRuWkqiNfbSuFPQhEvTD5sv7P1P2oyHLimUZzVbC27vNLqonPAyeSj1Ca6DWjprduFL8s2fumO75jkravovRtF/GrUliPg2J8htNVMj42MYDrCtfJSxTrMLVGuGkL3GK/96hKqOKhhQpLM/3LPuumxwY+ySSQHFGcjbbeGBDuXjg2X3qAg4aros2T3wsgzoY1RU9HdpbORywdGWRjdWQWBuMXxQXf7p4en2RuJQ==
X-YMail-OSG: 9_x4fqEVM1mENGPQcpFOWQskF_WAyOl9ixAuGHirZ3GMcRe_ZL49tM8dm9.LxH6
 f_uWAb9tgo6PEcJSjxhmaFwdA3xS7MMQN2RBKOXaOY5U8ixstK1deT33k1CvrfvkT41OvcsdIABr
 kXIFaaCOtwHV3IJJUZ8LNLV9831g9okSxIvEx4K8WEDANH.wwfXoccKTY7Gj4AltJA1ePXl58EUf
 reMAlH8hKU3VA.vIfQXDwfBFetQWBXSDrGLQG0o8l4_MEUj9E3leeMSPZLedv93_EhyvcrkJxYw.
 g7KdhtUtjnNR5yXt_IKE0EjsR3sheAifa0GJ7STkSLZai9fcgA4t2l1qeXPNdueAd74oi6QAaRFg
 UQZISnRa_iXmKTSi.GgFo5NqnhTAOxQKXd5J_nOsOMNg0Z.sLjsZUADr3QXmxOvRarysgNrV9X7g
 yLOJH0zgeD5hlrC98GtDd1xwTCsyVX_j67bLrdC0yrOjP4TrF03LlaJjI_2IKPDMKLIy.lW69C20
 8AHIxMdN011uAkccXPnJmAIb2vuvDwxFOitdSnjuDvVposcBZ1r9UkJrSbQbDGmvTUdDLjNpv7Dk
 K9_5uAr_XLfZphYkgmySSeR9hzmFSc2DQo7eW4VKZSLrxvyPSw0AkBERMTby6Imoiz5EF6HCZNCe
 7MXVihYXrP5GUXUJGwfl1E1hpeAMxn.eUlR29UhzKVUnhOCNeasD984Tc8bNDAD5rr3QeMMvZLdO
 TWiTUDX_8EN3SVS8p5LxKcdSWQI4w46ZbZf4GWcT2HIIh8r_Ftos.amkc7JAAd7r.hdBmF0eK_tH
 ZmyU_.Xw8GLRPhmFfVL1XQ0QEO7GEZn8r9hvdcq4iBMiRzVXvn7Ek5.yyQUm.SdLv3bFLrXTeO4D
 hPoDUYPaTjK3BzxulFuvDkfxsW6OuHWZH_31P3PFI73Ao.xvDptAdD0gf8FQGbKf2d5HJ53G.4Ms
 2_7YBD_Lym7rvQAVBI_AvNof0kKOPBOdACLG.UBoibw3SQOb94R7cTusoCkx5iE3WfMnu8Xucuig
 gc_Jfi2Jue.FzjmSnMrkrPqDhR6Saj5dR7NIuoBe3rbYioWsS70cHCKUMUswknoIMtBuXFay5gtC
 XLO28_YJcl1pYOBuJ31Zgqlw6.A6mAZ4oV0NmMSqf_8JjvwYqUzcT3xbMBB6j6_gW0u1H9ZGLmWy
 Sp6kne1up05GzFw2KbznuCRiSce5RIQLsIfMq6hWnt7ROsR7FGipJnvaARUHcssfT6ONcUnjwnLw
 FyIlXAHfigqJdF1_az5pwQikUHZ4.CRkp32zaiha0kXkouruyjLF0iptg9k8B3xNvU__8Xj7AhUm
 LxGE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ir2.yahoo.com with HTTP; Mon, 6 Jul 2020 16:06:03 +0000
Date:   Mon, 6 Jul 2020 16:06:01 +0000 (UTC)
From:   " Mrs. Mina A. Brunel" <mrsminaabrunel2334@gmail.com>
Reply-To: mrsminaabrunel57044@gmail.com
Message-ID: <405355093.5782616.1594051561072@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <405355093.5782616.1594051561072.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16197 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



My Dear in the lord


My name is Mrs. Mina A. Brunel I am a Norway Citizen who is living in Burki=
na Faso, I am married to Mr. Brunel Patrice, a politicians who owns a small=
 gold company in Burkina Faso; He died of Leprosy and Radesyge, in year Feb=
ruary 2010, During his lifetime he deposited the sum of =E2=82=AC 8.5 Milli=
on Euro) Eight million, Five hundred thousand Euros in a bank in Ouagadougo=
u the capital city of of Burkina in West Africa. The money was from the sal=
e of his company and death benefits payment and entitlements of my deceased=
 husband by his company.

I am sending you this message with heavy tears in my eyes and great sorrow =
in my heart, and also praying that it will reach you in good health because=
 I am not in good health, I sleep every night without knowing if I may be a=
live to see the next day. I am suffering from long time cancer and presentl=
y I am partially suffering from Leprosy, which has become difficult for me =
to move around. I was married to my late husband for more than 6 years with=
out having a child and my doctor confided that I have less chance to live, =
having to know when the cup of death will come, I decided to contact you to=
 claim the fund since I don't have any relation I grew up from an orphanage=
 home.

I have decided to donate this money for the support of helping Motherless b=
abies/Less privileged/Widows and churches also to build the house of God be=
cause I am dying and diagnosed with cancer for about 3 years ago. I have de=
cided to donate from what I have inherited from my late husband to you for =
the good work of Almighty God; I will be going in for an operation surgery =
soon.

Now I want you to stand as my next of kin to claim the funds for charity pu=
rposes. Because of this money remains unclaimed after my death, the bank ex=
ecutives or the government will take the money as unclaimed fund and maybe =
use it for selfishness and worthless ventures, I need a very honest person =
who can claim this money and use it for Charity works, for orphanages, wido=
ws and also build schools and churches for less privilege that will be name=
d after my late husband and my name.

I need your urgent answer to know if you will be able to execute this proje=
ct, and I will give you more information on how the fund will be transferre=
d to your bank account or online banking.

Thanks
Mrs. Mina A. Brunel
