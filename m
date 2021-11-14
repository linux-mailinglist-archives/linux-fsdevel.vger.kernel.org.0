Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A411E44F7C0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Nov 2021 13:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbhKNMGX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Nov 2021 07:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhKNMGW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Nov 2021 07:06:22 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F875C061746
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Nov 2021 04:03:28 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id y68so32562398ybe.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Nov 2021 04:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=l2AjIcA200luhAvIV6Y4Gf8Evv6mr+gMr0zSOMeBGF0=;
        b=O5shjqR7V94u8lW5LNlqSj9OcKZvRoYjDfvIKLY3SMB0okt+/PqCAbFKwNlpcx7tEo
         /DqjndkoPj0rxVarm4iF3EVgO/5pkJTG2vfEeLozXqvi/nrd/RTD6r6QjaLBgmrdfb9e
         hY/9DomxiWxlsqwjCCSt/dGG+USzFlZd/lQ8vkotGaQYT1p1v7yGVhtmDjRxiOH1r/sz
         t17iuFcI/jzcwLkYTxIg9Ky8BJ3ZOkqxHGdz9T3l+X/72wMynD8AOvAy/m98f3rIkPQC
         GMBSDHocVTK3vaGR7pkeVfpnYB4uFpq3BgPJbOiTvqIbhH++KVVuiBmk85Ypcv8sO1qU
         6XgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=l2AjIcA200luhAvIV6Y4Gf8Evv6mr+gMr0zSOMeBGF0=;
        b=mva5sx/GVOEIExuJcKa8ky/vwW8b533PUsa/3eyTe58n0xhXZZPQo7+pm3vUjwZaho
         2FbNDfZXwZsh2VB/lEg5nvNyzGwyUO364K8vVJk/A/JGwL+FRAR8ewAjV0GO/lV91Ms3
         TiJG5SMJs7tsfgb4WuSWYnPiM6x6njCEwaAt+K76Woy9t8Q+Xt13hSq0Ntzc2p/wP9kj
         fe0EfkgjkDmJAsXK2SuvEP9y2zv5lg6xCOiSpFjIjMpay6JYJa8xGzCZCICgRWnCe+xg
         H1bvgFSno0BBHh5ugdz/dAn15VysL0EJlQT5NP2Kqb0zYEipL2l65Np5chC29GSgXXvF
         Z5PA==
X-Gm-Message-State: AOAM532rC0g8z/H40jaoLgutSWafs3tvUOdpc+nDvWaHeKJkQ98d+2ss
        Q9HqQU/QJJ71fKox8FDzMsyryj39qPO/wk6gd6Lc68YCEjQ=
X-Google-Smtp-Source: ABdhPJwNE60F9CXIyTOO7xllBY/M+VdWUgIbOw/LiSTM1SWQ/r3eIsv10sxzDGNBw7DIke84+WZyMvnvpHhwHaBfdNE=
X-Received: by 2002:a25:1102:: with SMTP id 2mr32727351ybr.266.1636891407438;
 Sun, 14 Nov 2021 04:03:27 -0800 (PST)
MIME-Version: 1.0
From:   Turritopsis Dohrnii Teo En Ming <ceo.teo.en.ming@gmail.com>
Date:   Sun, 14 Nov 2021 20:03:24 +0800
Message-ID: <CAMEJMGFtEwxQzJ4jqSuCdAMgo6q-HOqPMwKk6TR=m_3x3d10rw@mail.gmail.com>
Subject: I discovered that Aruba Instant On 1930 24G 4SFP/SFP+ JL682A Switch
 is Running an Operating System with Linux Kernel 4.4.120!
To:     linux-fsdevel@vger.kernel.org
Cc:     ceo@teo-en-ming-corp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Subject: I discovered that Aruba Instant On 1930 24G 4SFP/SFP+ JL682A
Switch is Running an Operating System with Linux Kernel 4.4.120!

Good day from Singapore,

I discovered that Aruba Instant On 1930 24G 4SFP/SFP+ JL682A Switch is
Running an Operating System with Linux Kernel 4.4.120!

INTRODUCTION
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

My name is Mr. Turritopsis Dohrnii Teo En Ming, 43 years old as of 14
Nov 2021. I live in Singapore. Presently I am an IT Consultant with a
Systems Integrator (SI)/computer firm in Singapore. I am also a Linux
and open source software and information technology enthusiast.

You can read my autobiography on my redundant blogs. The title of my
autobiography is:

=E2=80=9CAutobiography of Singaporean Targeted Individual Mr. Turritopsis
Dohrnii Teo En Ming (Very First Draft, Lots More to Add in Future)=E2=80=9D

Links to my redundant blogs (Blogger and WordPress) can be found in my
email signature below. These are my main blogs.

I have three other redundant blogs, namely:

https://teo-en-ming.tumblr.com/

https://teo-en-ming.medium.com/

https://teo-en-ming.livejournal.com/

Future/subsequent versions of my autobiography will be published on my
redundant blogs.

My Blog Books (in PDF format) are also available for download on my
redundant blogs.

Over the years, I have published many guides, howtos, tutorials, and
information technology articles on my redundant blogs. I hope that
they are of use to information technology professionals.

Thank you very much.




-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link:
https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwave.html

***************************************************************************=
*****************

Singaporean Targeted Individual Mr. Turritopsis Dohrnii Teo En Ming's
Academic Qualifications as at 14 Feb 2019 and refugee seeking attempts
at the United Nations Refugee Agency Bangkok (21 Mar 2017), in Taiwan
(5 Aug 2019) and Australia (25 Dec 2019 to 9 Jan 2020):

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----
