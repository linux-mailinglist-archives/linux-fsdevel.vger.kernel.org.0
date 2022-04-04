Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FD14F1AEB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 23:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379312AbiDDVTH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 17:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379464AbiDDRLU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:11:20 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D530C237F8
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Apr 2022 10:09:23 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id b17so7945930qvf.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Apr 2022 10:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=VcPjK2xIshaSha7P/73c4uJIeEh9LCIV9h696014eSY=;
        b=0/1W3PtmahDM2zaiwQOfAOI7x0n7aJlY78Edx82FG8yn3sBRYT/xK8rwyUWlSIPkVk
         FbhTcMOufB5eBtNbzu+A7OVMx2KouPMqLL4fqMN5fXrX9FdDb+g8E/WNbt7rmfNyOJqQ
         3yTps2pezT8XzRvoiqVDfU0khY6BzaT9b9y+qgU1cNgUC5dLdbyJ926rZhqt1ZSdlvB7
         wu1tox0qINOoXy+nUe+Na9v9dWOAA/GUbXFNkrYHSwHS3aWbXTRBR4ZEacGNaIi8qzUK
         oh7jsSFehuBrZbWoTHGlWiHmYACJyn+L1iSBP/T8RxtxXRT0rUV4Sb16jlJtGgFKMGWg
         lnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=VcPjK2xIshaSha7P/73c4uJIeEh9LCIV9h696014eSY=;
        b=GtLGIF4QMty6k/+dN82w41aZSfMGgeeb0H9vIi8UNJJ1ST8Uo3BvlSdafAkB73HXjQ
         ptSxcGS4iyVeNBXftBKojjz8uuRnl80pefufhF2Qr8ElbPyE8RP0PWfMSjVV+ARQNx/2
         Y+LP3X0QyGlJG2j2y+ILr15ARK6jRfqUnFAItdE7eLiBK5QYCvi6bwahislYZzUxjhJ4
         6o/7qid72qhKFzcaDtkPN813r9uy0DAcSLShlJcWhMbDh+ojh9WSBUeml3LB6UHHVg9T
         tZJyxrxhUxtA9F6G6QJo98IjW4eOKbUgtkBwYRoDrwyRvsmUeJRxdHfavfA53Z7aar+J
         iJgw==
X-Gm-Message-State: AOAM5307e6EFXN39C8871nfGfRQcdOuzw69ZEbWsZ5VLg3R5ur/dto2P
        X+gxJs3XK6gp9Fm0+zVY/t6X0VQtU1eJEA==
X-Google-Smtp-Source: ABdhPJw975xdZtFy73BXNqDffuAX0xg4/F4udCpxsEE662P0gVWTk/Y3sjsyhUGgB9jNpu/nvzm/zA==
X-Received: by 2002:ad4:5f0f:0:b0:441:1e3a:dbc with SMTP id fo15-20020ad45f0f000000b004411e3a0dbcmr485180qvb.99.1649092162831;
        Mon, 04 Apr 2022 10:09:22 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s13-20020a05620a0bcd00b0067afe7dd3ffsm7312292qki.49.2022.04.04.10.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 10:09:22 -0700 (PDT)
Date:   Mon, 4 Apr 2022 13:09:21 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     lsf-pc@lists.linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: LSF/MM/BPF: 2022: Call for Proposals VIRTUAL OPTION
Message-ID: <YksmQSfuIx/OiNA8@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a follow up to the original CFP, you can find here

https://lore.kernel.org/all/YfGnDRM%2FPe4jzbSr@localhost.localdomain/

This is for those who have been waiting for a virtual option.  Those plans have
solidified and now we have an actual process we would like you to follow.

IF YOU WANT A VIRTUAL INVITE PLEASE FILL OUT THE GOOGLE FORM AND INDICATE YOU
WOULD LIKE TO ATTEND VIRTUALLY

https://forms.gle/uD5tbZYGpaRXPnE19

The track leaders will send out individual invites for the virtual component of
LSF/MM/BPF.  From there you will register like normal, making sure to select the
virtual option during registration, and then the Linux Foundation will email you
with the connection details closer to the conference.

The virtual component will be hosted on Zoom.  We will attempt to make this as
seamless as possible, but anticipate it being essentially a glorified
live-stream.

Those who already filled out the form indicating you want the virtual option
don't need to re-submit, we've got you on our lists already.  We will be sending
these invites out as quickly as possible as we need to make sure we have an
accurate count for the Linux Foundation.

Thank you on behalf of the program committee:

        Josef Bacik (Filesystems)
        Amir Goldstein (Filesystems)
        Martin K. Petersen (Storage)
        Omar Sandoval (Storage)
        Michal Hocko (MM)
        Dan Williams (MM)
        Alexei Starovoitov (BPF)
        Daniel Borkmann (BPF)
