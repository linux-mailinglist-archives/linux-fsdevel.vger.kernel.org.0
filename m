Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9966135A29A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 18:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbhDIQFG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 12:05:06 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com ([66.163.186.211]:44636
        "EHLO sonic310-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233889AbhDIQFF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1617984290; bh=hx2AE2I6w9Qq9AGRy34zDwr9Uc4ea9n2GR6ByjcrG9s=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=B+QJZ07h2oNd52a1X5XcKgjVNBUkXJElSH7AUPTlJvC6WXDMLVBKGyN5viXJ1BP3XM7tWK3M+QGRdPxbmmJbn4R6oo48+8od68lMjbhXOiAyEGR2q7n9e2MUOZ07EkdqzMjvlLlSACQ286nRxTI++8P1ttGZADn7pY8ly9xxRoHna/zxv9AVHlEwLwjtpL+DnhAP2CC6nLc5DfhSF1QSkIlSlyvTUhNH7zHyRsSVqd1LYdWD3dbT68ysscnn2ERnApUr8wzshLaoUN/1XTGd/yTCZEnScu2jyCb4HzNHHnHg3zO1ypVVzKrcz5b692+MuIZXE8QOwxN2yDyUPa3MYQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1617984290; bh=Lcd3vERvJtsGZPqBzW+44fNU/kSVsstAYRF57V0GSZk=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=r5gfO0QwIux+UfoKei00oBCP4hBXjZ0FSLv3xJW/rv00R5m2MH3bCtqh1PwFbQAGIsfpawSmAGlJGtBeqJ58/UaeoV3AVbei4nqoqPQ7/YoHyA63PseFNcA349sE43X2NdHLcL1tK5hcqDmtKyouW8biVv5NMfQyUqVgJBnDbdLt3hzw9XttC8JMbXi2oyvIsH7ta8yYTD09c5wTK9IPj6TcnAJrzQ8lKKcPo2mkZVKLeeo8TKm9T+ya2HMBT+sQ3VxceONGtnZtJ4UZlNN+HKHEdYuiIsOoH8OTmiGJbKn8oC+aTqvHCpEFvZmePkB+vnn2VuDLPFBXbdNsXQFMOw==
X-YMail-OSG: m9Hr8bwVM1l2uVBPYry5Cr3m7UXU5F1xrdNlNk3Xzu_MRCV1GKlNKyDAlKx6vjc
 2tLuvOXfEDsv9lq8rCYKWqDbicn.iby98MEWriNsAoOsEcSQ6ztf5aQim_3o4xAB9KL0zZllAoGv
 HnFfOg7jLhnmF0wsLg3JELyxskmU6fBkxQGio1NZIRy.kBtDN3lyxWuJzeALGoDTdTxszfvH7mDD
 1tBGc3h3S1HdvARMqanihmUx_qJaVEVdno6581AO.UrcTo4Uu1KmJbThMIN38ZU7vLLRtHTN2gxC
 aYsvU.UWFnotv66qLTH8Vlc2zXXJzG.PuPtyH2OwtLaMlxWdP60VP1Ux7FDov7p4eZqEog3xtqBY
 2Nfr5vHJu5vb_NRwOpDHCVZBPO.1B3PDMiM0WDTCR7aGIC5h6QBVjSSjn8h2bKbmRWxmx1PkPA22
 G.oXq4nyEo9KGSCFBE_7UAH2eY8_qz0s0v9xJt50SnUwVeEuwqz0K2y._kM8ljhLe_QnszLlhj_4
 XchHKBRV8ZK54JpOvWzTC4TVc5b6t8s0FqfKG4PhdUAl9KdHOeznuQrerXsIB1A6AfuZEv_B_vwn
 nUD7JUGqujefLNSYIRR3CHzDQ4NAB7oPtc7_u3OdGbl5vKLH9KOxwP92Ra55BtyeheR.D5hPYvOr
 unbB8hAhc.7xigk4dphOMUwwMfEzMT9X7aw1VJtoWENVixigLA1hCCLvUUxBhkuEICst.sYeQjkf
 vMSqFG.A8HZ6pGsaE7fpQmZFpXyHGPK.pnbKkysVAqhn.JzlG2u2SXSE7i6DGwC9GLDuDtU11mhf
 bGdIGeoHR8x14tyvV3WWpGTwzMmI4JMw9axszFQuZ_hQnyeYg4BImSIPvEfyZqxZznL6KNQ8_GVI
 LXXgk2ZdjPG.vX4t62AurrHuzCvg6mq83fzFgrTFiK1Z64D2fTNAO5VCjqCzwMiHEa7MT8MACjX6
 qP1wlIwH3q2wanEJdAJT9cSgqTSqwrRxpN49JqFCHMKYxPc3RopKzFdAFCGlFl0M3d5fP0RjqOKB
 lyl.6QCkDir2mm_fVnjgwsEgm1GAS5sXaeyaT4lOuT641dtbTMOi5PhOf84FtY6MGsFwvvLBEX9Z
 fmmbLEt4fpxb_7LOQga2K7N6iFnP9s0Cm3CzAAY41.ppeoffr2syWeVaFX4hYyELKhjo_02sNqsV
 HkuiQ5Dh6zFU61UurgLmXMKC9olqi7eVc8HNIUybkonFCBo167dLtIUXmwQ5KTbYeHC3IHhdT5Tq
 yNErWuIHTozX.1iksdPnS6B7rJ5aKm_3PMU8Of1YqOl0oN6q5Ok48f4cMYiGJ2Pjma7QTEMLQzwE
 yPwh.KgbvvGfno_.wkFVpKS31gL8hK_LaMFJnvPyuVL8BFEvuv9kRNYS2jddLgem9lBx9aJ1.RZR
 YmZ8NcgnXg3H0FTxY1n7QMg8o9Xy0x4wzddFjSPLXCXV0ppNGITjKE25POWe3c3W.4CjIMcnoKdH
 DniuXlOmfJgxmAbK3US7R44yaNuX822wRPFbQh3JT4E1WLU11Wfo6mv_TSh_wjMvjYV6moBWWPkd
 zDYt.1Z7O8XssTRFjhfJy6irI2U4.d8p6mhw1xRKIAD5RQbwSgvmmVoV_5Gl3FniTRjAjUA8O1MZ
 L_..js.W_7v3BPJBhF9mUDUe7hNHWxiXQ2NH.kWlcxl8HY7LHyLG6Hf_MHFKhp8lw2vh_EkiR217
 JPLGI56CqEILkWdv5EL2a3fD4c3L6i5h2D95Hw8XlA3byle3DjWVJfiZ0efFOfOafeBKcDlZV8ps
 kzU7ygyKoKkLZy1o_lXzVtgnkebl23mfbPT3AcVaXgFnXL2jf74qlcH.DIEkdGn2CBvcjW62L4Kc
 78l9FuB7Y_XYlU.K9mn7dmLqPsdxpQo_gwjYtxUIBUxP_dC8qk4I95POHt.vifsJUcA50gX8kf9d
 n.kWoeMJqwA5tAzYx6Lv.kp7N0Bop7EgnwkFLNDbg8hCOrPcUylrupYUUuFb8ELEyqicE.Gn6bfu
 S4Fo0b0plKOg3daZS43hEjyVhfeZ9HARdGetqUVe90AzZVWpNh3lCi5G6syamKGDoDnN92a_b5km
 P32R8T0Uc3BmEvuCc2aaE6GQ32XiGpdKX0Nd7ryxmS8OfiLC2e3t8LEtGIOa4ZFo0vc6o_bdMcZE
 Gaw6asjk3j7bc.5.owOvoIGn2b0LNE9w6mF8ESG5vSgMvJaDHZdazf_jJW6c6exhUoo6Gio3d..d
 7Sm94CZ2S24AhOlQOOncuUtRESZD.GYBSRvNKBtqYUuilxC71Ffk0UU4sTvD5tdGt7y7jdkEVRhs
 vxq1R7cOG44dEya59lvowXptw37ZqH0F4XJTRW5gxo6MA7jY7KN4v8eWZ.QiHJ5n6PpIkRM.PVpX
 rbtZUgCbOMpFRbidIYjaH0ZaK791mENRJs5k0_J7eEVFSsIClQePQynvkJgV7AT5CkwAdfYrtdTf
 OTospNChy.FVFg3tgxZmmB9G91qiIBsV.pFeqR1WuAClAhbEVAMACIsz_ZN1KSd1BwISWlI78rvu
 vZiecj_3BolxUlaW5Ym5Xxxe1S3VO0Q_7VJTIapvJtQdt.uilhaEKpCQWEBdqRM8EziapzHxtfsP
 s8IXEZyOuHeU8e5NrZ0x_wzZ1W7TltPN3IlNcWBMT7_eHvCa5daDUl41DR0uuogiMTYfGrxDmUpY
 _PJMu95XuSzvA05l4rY2ZT6eYIg4C8vbH8DmrfDe0fPkaWhco4mXZAu60qZUKc70Wrk_fEJtFy3Z
 p6i6.96pNtaEiYwL4Ns_5IRhjgrkmLWUjHZDsXoSrk5gAxpQK4Akk23YP9XGuhjDOnPqQDbRSz3N
 4aHut4Q5LZwdKCzgu2s4kG9SfSy5tAxVSpw6gtCXo43V46zZNXD2_EHLSgKididIAddhS8jX_4TW
 TySDmWEZnm3nq9ERhSslVnE66r1QQrs.EpisiZYeT6VRy4c6QwfN46rhy0.VTPlut5rqt7LLyKkm
 HjeIsuL31DvJQkXuFCxINP5gR5s8545d6IfsRatKVXo6WNt.hwQO39xEHiOzGdRB6NKPEXO7SNxk
 yFDBBIHVvtK7VluyBhn5nRyn4t4BdK3FpILSbdH3gEvAc7vnxOxy3QRwxsllYTSuG9KPl4g314b7
 Ae0caUN2nfM3Zp1kvhXdx3qYzCS_ioLeOSTp5dLI32FUuKou_07Qohie2ikgOqjmIBamGoMMcR7L
 Ikr2yuH7cB4NOJKqsytmww_mpt.N6YHEcbCA9bMcalPtrQfX8g0CThOf3K_2GpJF4HKnTyj.Jpxc
 L1IxhQPhkbxIS3p2AzzeUVyEyh7XzIcnumKCy0XDyLfFrw1gxecT.OSYYnO_PEHc052ArjgUl8oy
 P6IaucIknckoy90hKF5b_1E.L6LS_O04_KgoO9YueWpDaozd5fnYxdyuKo2Nsskcqq5G9wPiEndr
 kWFRiND.CJuIRXxkOSI32VtU7fTrFEn.jSh18GP1svvGQEHMH1dSWj7nTEWcWUUR0M4TXF03QcrZ
 fLie5JhOlDCO7UZsRNrS9Yur2e46BtwN1zXVKJau.gP.6kDq5ZgqiVJTkjyYfTiZmkR2wq2UNpMB
 luPCc469qvRTVlwedwthx9dm28Xxvupss2jG8aaykurWYYwI2CU88Dv8QFrvvIXMc.HQHyyDuKg1
 0CqWQ3oVdbf6m_uMUYx3v0bhc4fkCY5TJSC5ib2RPV54ppAX_6ZAbr5ZS6DU75sUKKP8P0xB_Yoi
 HJSN24naPsejZhosPkjqqDZMEQ5WzKOe6guQwlgPr0VJWnKzEBeRt8KX6cLgETX6h5GVazu1wa2b
 VhYOAccwo0zLJ6Vu2Y5eARB8vq1QtCzX5bt9VQC81oJQTsVoNBabL44.E2d6wagI8mwpQpjjyzOp
 NgEDW3N4TiQyHa4R5KxH1FdLacqYydN4qeVsn6MH_7mf7oRL0PO.UhXo2QYg58E11LZvHtmdrwxa
 .BuYfYzBlIDPQ8tV_QjvU5KE4rJY3Gz4qrsvDxKyGsT.N727r1Soi4oHHu4KUPlxzT8zVJE6o1.H
 9VhknZnN1UheYE9kwgiID120URjvsxKMPWIDF0mmvswejKej3Wsr.6aSJPyNCkzEF3UptWGgI99y
 495tEdPVz5rsaMaVpBo9MvLMPCPIPpPtxl.H5Q_t7_PACsUnXqVLv8JezwNHqTnnGr1nYaBYS53Q
 VJ39_brtxVWjrzXYbdUczrJq7smS_L3QvU8UMOlj6JRy7IQHfhXz7oPAKBTWMTpr2Ka3z.jME_g.
 Z.wlAkyi.qUrCn5Byug3OmYt8.QL9F9nVibmiJDhr2UQvlNKvU.vyMm5XLPZ4pF_QEoQ-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Fri, 9 Apr 2021 16:04:50 +0000
Received: by kubenode563.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID a2480e1f2493dc0ec318d730caad4606;
          Fri, 09 Apr 2021 16:04:45 +0000 (UTC)
Subject: Re: [PATCH v33 00/12] Landlock LSM
To:     James Morris <jmorris@namei.org>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Cc:     Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org
References: <20210407160726.542794-1-mic@digikod.net>
 <d7f25c43-8bea-2640-292b-df2fcceae428@namei.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <9e4e42a3-937e-710d-8ccb-9bcb0969c5cb@schaufler-ca.com>
Date:   Fri, 9 Apr 2021 09:04:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <d7f25c43-8bea-2640-292b-df2fcceae428@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.18121 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/16)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/8/2021 6:48 PM, James Morris wrote:
> I've added this to my tree at:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git landlock_lsm_v33
>
> and merged that into the next-testing branch which is pulled into Linux 
> next.

Thank you.

