Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01292656C87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Dec 2022 16:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiL0P2A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Dec 2022 10:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiL0P16 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Dec 2022 10:27:58 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10305BE7
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Dec 2022 07:27:58 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id j8-20020a17090a3e0800b00225fdd5007fso3880239pjc.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Dec 2022 07:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:content-id:mime-version:references:in-reply-to:cc
         :to:subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ASoHy6OScQmpw4bK1n2Ii+31l8avJ1MNn3Rm11G5sRY=;
        b=JTRvHazi+STDMGNST2mSlQjIDFhRu2fKLHLEjViu1OvNU4E5xDepZtOvPZ+ajLutqD
         Jx/ucxMeX5WjrAWQgpIDll9OP10jYmfg4UwZnvYuOrOjkOM/5GqnTf3mADk/0c9aQ2rs
         6LozNbAX0jOt89N77g+cF9GkriC4trjdx6vxJzBOKuUiMPBuzWO6aD+xKDJzjqSxYh+w
         IelKydq0LY44rezN97tV1E7O9UdkTmOc4qGMLsUV+dKwG/Y2Tk8/+v5626qGmZsgE8ya
         PuhD9QIauJAFsyQqBKO/5TPt8OIDaSpOxz3euWzlApEEBqRBY9LwtVMshv24505up8WK
         UorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:content-id:mime-version:references:in-reply-to:cc
         :to:subject:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASoHy6OScQmpw4bK1n2Ii+31l8avJ1MNn3Rm11G5sRY=;
        b=gBPd87DV1+k77NrQacWONY+2bA51v5Ppxj9abODiKqzbb3s5XbYQ70UpfRb8bkv5Lh
         FbPOg/ONbfLNwTLZenfI/swBLwH6T1cfm8q0Wn6jjGlbHf89NnX5c6afiTYy2FKFFG6g
         hgES8dfOpawI257Y1UZDiKXJVloewxpH8gpjoM7C7v0MBYhBr3Siu0szPul2ttEPkmFM
         jNbzc50EDamG7rRoNyx7TYom3eHpYbTlUvq/FvQSx9+vldBGuHRIEZ1YNU6M55IOvq4S
         reVq1+tUUCxoWljl5gOfMhmaxvrvcvrrLJ9vm5nNhjUfFUaPA0Jwn8+PavatXo3DAwFY
         lXIg==
X-Gm-Message-State: AFqh2krF5pLwMweaNH/vjgTA2tJuoAon6I/kLj0Q/tz6P3azcYxGUGrq
        k3Myes3oXtMiyMYmytB2Fso=
X-Google-Smtp-Source: AMrXdXulwQ2O7iPj+eECV9ptpfsp8UWYezRHBjg8YbTb70OOeBqjZPdn/VD+o73yiviQ00kfhbq2AQ==
X-Received: by 2002:a17:902:768c:b0:189:e360:ce5 with SMTP id m12-20020a170902768c00b00189e3600ce5mr37294180pll.12.1672154877525;
        Tue, 27 Dec 2022 07:27:57 -0800 (PST)
Received: from jromail.nowhere (h219-110-108-104.catv02.itscom.jp. [219.110.108.104])
        by smtp.gmail.com with ESMTPSA id k11-20020a170902c40b00b001926a76e8absm6329562plk.114.2022.12.27.07.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 07:27:57 -0800 (PST)
Received: from localhost ([127.0.0.1] helo=jrobl) by jrobl id 1pABrv-0007aM-4Y ; Wed, 28 Dec 2022 00:27:55 +0900
From:   "J. R. Okajima" <hooanon05g@gmail.com>
Subject: Re: [GIT PULL] acl updates for v6.2
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org
In-Reply-To: <20221212111919.98855-1-brauner@kernel.org>
References: <20221212111919.98855-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29160.1672154875.1@jrobl>
Date:   Wed, 28 Dec 2022 00:27:55 +0900
Message-ID: <29161.1672154875@jrobl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Christian Brauner:
> This series passes the LTP and xfstests suites without any regressions. For
> xfstests the following combinations were tested:

I've found a behaviour got changed from v6.1 to v6.2-rc1 on ext3 (ext4).

----------------------------------------
on v6.1
+ ls -ld /dev/shm/rw/hd-test/newdir
drwxrwsr-x 2 nobody nogroup 1024 Dec 27 14:46 /dev/shm/rw/hd-test/newdir

+ getfacl -d /dev/shm/rw/hd-test/newdir
# file: dev/shm/rw/hd-test/newdir
# owner: nobody
# group: nogroup
# flags: -s-

----------------------------------------
on v6.2-rc1
+ ls -ld /dev/shm/rw/hd-test/newdir
drwxrwsr-x+ 2 nobody nogroup 1024 Dec 27 23:51 /dev/shm/rw/hd-test/newdir

+ getfacl -d /dev/shm/rw/hd-test/newdir
# file: dev/shm/rw/hd-test/newdir
# owner: nobody
# group: nogroup
# flags: -s-
user::rwx
user:root:rwx
group::r-x
mask::rwx
other::r-x

----------------------------------------

- in the output from 'ls -l', the extra '+' appears
- in the output from 'getfacl -d', some lines are appended
- in those lines, I am not sure whether 'user:root:rwx' is correct or
  not. Even it is correct, getfacl on v6.1 didn't produce such lines.

Is this change intentional?
In other words, is this patch series for a bugfix?


J. R. Okajima
