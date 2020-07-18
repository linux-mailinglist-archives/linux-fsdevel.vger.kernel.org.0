Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138CB224BAE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jul 2020 16:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgGROHM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jul 2020 10:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbgGROHL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jul 2020 10:07:11 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8C7C0619D2
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jul 2020 07:07:11 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id s192so2736986vkh.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jul 2020 07:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=t0TLC5mt6zw20J38nO6UV1Kz+5E95WBtIXeRkoxQ4a0=;
        b=Am9ljAu1z8n/VTgYAl8DNuZVX+OPh5GNt9bBDdhsRGP1okcxPTRdHI3vgADTK7a/Mn
         TZBVGZs2eSDx6R61tHuLF6qI/duSqXB2kAx5zcqaswpt636yWn8jFi+AQOGZz04y6YhW
         +6rtXxDhtJ/c/QwJaGocsAm8PgrXrIhxavdU0rlNBhuOF07xejXI7Bs0olEQUTc5Nr6C
         sQP8eVFpJF9GMWkV8bU14TGdFB1lroMxtltanXNneSHDm4VHmqxaFlKMRJ2FY+zH6Hkx
         uUnSTM1+EhpLA5E65bUzpBncbeYjdfJe4y8S+noBVjDDz+0AAKKgabqrjQ1jXhPTP3ij
         fvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=t0TLC5mt6zw20J38nO6UV1Kz+5E95WBtIXeRkoxQ4a0=;
        b=AAFLPl4Zy1c/BEHQe2JQswptPyLDbQvG6f8O41mYcPL/of+/Jh8nogI3mWkTtjz4J7
         r5pXwP4OV8nYvWZAPKL+3aR00uaRW+Fu9PtO3bR/NRsY80QyVSqzzhHLHW+JzaS4MJFi
         +Lb859BXR0ouPD2kpKtud7wohtZYbH5eu9fJeb3rxZvA9yWkEMShLlPOoEeseWgJDC9w
         eVGaprho0V4TIXDvUrbgHnmnHUxbNYqKV0yxfkjTcJhxBTKGsnOvSKBGEH8LRBbDV3Yn
         9Bv4Y8OP9YHBd3dvBpECLs5lNvw43z1tIFW+D8YE3kb/eorpnwipeX66UJ1LPfWcQHBm
         Y8bQ==
X-Gm-Message-State: AOAM532diOoTkxbmFM53e9ryFEMbW103ybXvK6paiU6FfSVLWeqlieGi
        IqD0RghBOEW3hvgNJOM4XUBSHE9OKcT7/1hfiDI=
X-Google-Smtp-Source: ABdhPJzC0BlCpQMBPttVEYFoI1GvaI4DKmsjb5qN4oZi0QcUrkpguDYueoObncLuIJrdHcKx/X0ue6qBn+d8T0cWVd0=
X-Received: by 2002:a1f:eec8:: with SMTP id m191mr10622921vkh.47.1595081228789;
 Sat, 18 Jul 2020 07:07:08 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mrsanna.h.bruun119@gmail.com
Received: by 2002:ab0:194:0:0:0:0:0 with HTTP; Sat, 18 Jul 2020 07:07:08 -0700 (PDT)
From:   "Mrs. Anna H. Bruun" <mrsanna.h.bruun119@gmail.com>
Date:   Sat, 18 Jul 2020 07:07:08 -0700
X-Google-Sender-Auth: i7u3HLFxfKC2bCjfGs0pcbRtzMI
Message-ID: <CAKipdRmMezYCUBC-HKZoUPJrNUiF++_ESBrtE+gYib=jVho5uA@mail.gmail.com>
Subject: My Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

My Dear

My Name is Mrs. Anna H. Bruun, from Norway. I know that this message
will be a surprise to you. Firstly, I am married to Mr. Patrick Bruun,
A gold merchant who owns a small gold Mine in Burkina Faso; He died of
Cardiovascular Disease in mid-March 2011. During his life time he
deposited the sum of =E2=82=AC 8.5 Million Euro) Eight million, Five hundre=
d
thousand Euros in a bank in Ouagadougou the capital city of Burkina
Faso. The deposited money was from the sale of the shares, death
benefits payment and entitlements of my deceased husband by his
company.

I am sending this message to you praying that it will reach you in
good health, since I am not in good health condition in which I sleep
every night without knowing if I may be alive to see the next day. I
am suffering from long time cancer and presently i am partially
suffering from a stroke illness which has become almost impossible for
me to move around. I am married to my late husband for over 4 years
before he died and is unfortunately that we don't have a child, my
doctor confided in me that i have less chance to live. Having known my
health condition, I decided to contact you to claim the fund since I
don't have any relation I grew up from the orphanage home,

I have decided to donate what I have to you for the support of helping
Motherless babies/Less privileged/Widows' because I am dying and
diagnosed of cancer for about 2 years ago. I have been touched by God
Almighty to donate from what I have inherited from my late husband to
you for good work of God Almighty. I have asked Almighty God to
forgive me and believe he has, because He is a Merciful God I will be
going in for an operation surgery soon

This is the reason i need your services to stand as my next of kin or
an executor to claim the funds for charity purposes. If this money
remains unclaimed after my death, the bank executives or the
government will take the money as unclaimed fund and maybe use it for
selfish and worthless ventures, I need a very honest person who can
claim this money and use it for Charity works, for orphanages, widows
and also build schools for less privilege that will be named after my
late husband and my name; I need your urgent answer to know if you
will be able to execute this project, and I will give you more
Information on how the fund will be transferred to your bank account.

Thanks
Mrs. Anna H.
