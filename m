Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21D65CEF04
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 00:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbfJGWXg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 18:23:36 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:43289 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbfJGWXf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 18:23:35 -0400
Received: by mail-io1-f44.google.com with SMTP id v2so32229135iob.10;
        Mon, 07 Oct 2019 15:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=wtsrMTezMsMxm5sa/uRmr3aD6zhnFoeYnC8Qx+iHozI=;
        b=s9Z3kxPAzg4e2b7LKdU6A/6PvpjB9pfD/dfRVUCCLMGY3OOt3Wrt4QAR3SlM5cP0+u
         TC0axqez8A31MxpWEaAzfwztS7KKoJHvea0j+YQtuUMAg9fv3N0ASvM/PE0ROuqFGpqE
         PxgJ4r86HBx0cV4LNfZuFeto+aQdRQ8KAV9zkE6HxG+myrDp3LBB7uQNIO/RFZDzYMtj
         jGcCD16VxzSq5195XZFf5Z6NkIR8za6iood8R6d30hDmCF43bYukcjEOiDem5bcpZLYn
         0QOQpWxVdCnCNPgfMQxU3woJjkkQ/uKE2oJoVEKptX2lRD8TJ58w/7Vm77g7+0EpxUuW
         /I3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=wtsrMTezMsMxm5sa/uRmr3aD6zhnFoeYnC8Qx+iHozI=;
        b=JIfz0OqjsV5r+nOEehPd47FK/0gu+af7C9TRn+kDilVQHfILDlyXX0zydvNa+5bixE
         9fIUZQDoAlOaHAg4D1NOQHM8/Dnaw9TnkBPvX5cM7zaaYVAwoVCu88Ck8d6RR5oJObRx
         igg3jFAvA6ASWlo+peWsAdRc6OmTwFDMuRfDqmNpMvSA0JgxyrX4BtmR+9HKeJ6lyKkV
         GcOmLP16PzHkc/HhAcQZheuMl7aSLFZkWxqMRia+jEkJb7KuvUkV3QR+H8A3KrkoN2PE
         KsyuZoWikFI0UProt5vPtTvszr9hYozvEL344x7+MAr6E3Q3bavJ34vhICkciD0MMUvS
         egPg==
X-Gm-Message-State: APjAAAWlp6Fnk6fxs8AfwZhYb8Gp1iRkp6Lv03cA4V/pLXVbhegrc7CB
        OIsLmrtUwt3e3QfipOGHqhphRefbRSA//lrT7Ky0WaKTgCI=
X-Google-Smtp-Source: APXvYqw9XZoqmiZpysY1ddWc+fFUEFWYK43wqt6qQry10TVDOw6zZx5HBOnoD6CXn8lmbAS6TYMOcHwO2t3U8gQIeKI=
X-Received: by 2002:a92:c00d:: with SMTP id q13mr32522103ild.169.1570487014461;
 Mon, 07 Oct 2019 15:23:34 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 7 Oct 2019 17:23:23 -0500
Message-ID: <CAH2r5mtgXZNC5wiNGRV925jB0H_HJTc_-GzBFFMoytmuJ5i-LA@mail.gmail.com>
Subject: 
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I noticed that the commit below regressed cifs/smb3 xfstest 258 on
5.4-rc1 and later.

"Testing for negative seconds since epoch"
"Timestamp wrapped" ....

Did xfstest 258 get updated to account for the new behavior with this patch?

commit cb7a69e605908c34aad47644afeb26a765ade8d7
Author: Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Fri Mar 22 14:32:35 2019 -0700

    fs: cifs: Initialize filesystem timestamp ranges

    Fill in the appropriate limits to avoid inconsistencies
    in the vfs cached inode times when timestamps are
    outside the permitted range.

    Also fixed cnvrtDosUnixTm calculations to avoid int overflow
    while computing maximum date.


-- 
Thanks,

Steve
