Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A149243B159
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 13:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbhJZLlt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 07:41:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40708 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234803AbhJZLls (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 07:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635248364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XU5PbqeylwTiSdIqGz9zsvIHQQKvLuWqZdWiVf/qrQc=;
        b=S4bA+iUqgDYcWX5x2gH/0uyf8dMDO/ThELldO8445FkYZmh2WtCemVWisz1EW8xzjIziI5
        zAiCSgs9DMARmKOlxrpnzHIinUG2RbV51KKpMA4JB7mPgezX1/Nt4hFnGmAKqjPqJhtk9u
        +PaHKiz8W5XAL4xG5tJfgNbfnee+5OU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-myqGOVe7MSWml0NqoEWW_g-1; Tue, 26 Oct 2021 07:39:23 -0400
X-MC-Unique: myqGOVe7MSWml0NqoEWW_g-1
Received: by mail-wr1-f70.google.com with SMTP id d13-20020adfa34d000000b00160aa1cc5f1so3901061wrb.14
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Oct 2021 04:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=XU5PbqeylwTiSdIqGz9zsvIHQQKvLuWqZdWiVf/qrQc=;
        b=FwdADXyZPSxn7xaN/dGgYc0ciFtaH1SP7Z6Ul684T1GRFkClA8Pr8OoJeJYWanq+D0
         J+HXHnGy7m0TNJajJ9OqjuLT7VtgLHJm1f+vhG2Hr5oIKwobNHU3r9yrInMXVmwV96Ge
         xwwKhJKg1vd7CkMyQvitbHWdAdIP/n5zAWn2LBsQeeqXldAxMwpnt4Sdfw18UQZjoNkq
         t0MXMiSQ8oMUH7J2W+pixeZCkTkS9tMGGsVUEXjBcmQTCVbKDuFzMz5NB1QWNCSLOzo/
         urJzylqVNqSRFRG4oUYD/wgiXvSG0IDQ4UHNluNHruN7Vu3ZohEh98/pv/ZtiFyD/4EX
         D1Yg==
X-Gm-Message-State: AOAM533lcLdigtbbnFCuJkSoPpsbEd9inPRq4pr6xaLgh83e9byYza/s
        LtFpNyjLX2E9RGBaLoVdQUQByRgFlmLtnMBXGnuRwlPzT2dO/k0KvXa+7EobvQGkt9s1YWOoifq
        wChkiET7nitUKaqAbkRIRhevOZQ==
X-Received: by 2002:adf:d4cc:: with SMTP id w12mr1042784wrk.275.1635248361980;
        Tue, 26 Oct 2021 04:39:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJUJbTYohBTQQymnO98ec+X7Nnr+4h7GZESd8sTcS7uI/Cta5XQOX81blWxBzpk6/9pT/cNw==
X-Received: by 2002:adf:d4cc:: with SMTP id w12mr1042749wrk.275.1635248361657;
        Tue, 26 Oct 2021 04:39:21 -0700 (PDT)
Received: from andromeda.lan (ip4-46-39-172-19.cust.nbox.cz. [46.39.172.19])
        by smtp.gmail.com with ESMTPSA id k63sm366066wme.22.2021.10.26.04.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 04:39:21 -0700 (PDT)
Date:   Tue, 26 Oct 2021 13:39:19 +0200
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 00/13] ext4: new mount API conversion
Message-ID: <20211026113919.iw7ikkvcdgmrijhf@andromeda.lan>
Mail-Followup-To: Lukas Czerner <lczerner@redhat.com>,
        linux-ext4@vger.kernel.org, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org
References: <20211021114508.21407-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021114508.21407-1-lczerner@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 21, 2021 at 01:44:55PM +0200, Lukas Czerner wrote:
> After some time I am once again resurrecting the patchset to convert the
> ext4 to use the new mount API
> (Documentation/filesystems/mount_api.txt).
> 
> The series can be applied on top of the current mainline tree and the work
> is based on the patches from David Howells (thank you David). It was built
> and tested with xfstests and a new ext4 mount options regression test that
> was sent to the fstests list.
> 
> Lukas Czerner (13):
>   fs_parse: allow parameter value to be empty
>   ext4: Add fs parameter specifications for mount options
>   ext4: move option validation to a separate function
>   ext4: Change handle_mount_opt() to use fs_parameter
>   ext4: Allow sb to be NULL in ext4_msg()
>   ext4: move quota configuration out of handle_mount_opt()
>   ext4: check ext2/3 compatibility outside handle_mount_opt()
>   ext4: get rid of super block and sbi from handle_mount_ops()
>   ext4: Completely separate options parsing and sb setup
>   ext4: clean up return values in handle_mount_opt()
>   ext4: change token2str() to use ext4_param_specs
>   ext4: switch to the new mount api
>   ext4: Remove unused match_table_t tokens
> 

The patches seem ok. I can't review ext4 specific details as naming and code
style, but the logic applied to the patches are fine. There are a few typos in
some patches that I pointed, but the patches themselves are fine, so, feel free
to add:

Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>

-- 
Carlos

