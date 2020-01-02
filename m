Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1DAB12EACD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 21:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbgABUOk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 15:14:40 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40933 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgABUOk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 15:14:40 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so40415625wrn.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jan 2020 12:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EZwwlNOvSvl+rKT7a1ceC832qWXYL65iR/7ilzgvcuI=;
        b=kSC/T5IVsJVXZ1QYz1E+5QtqlRLBa/EdDKM8V93rlOWMjn+hFAXbC6B4fa3/lBYxnF
         ZaUzPB2KCvhts83v80WiBh4FMPvDMgEuXO0t2oiHh5JRia3twRd3O87zwybgfSKnp/o2
         7zoj8f3mnnXI6VZypvIZdHpQqN/EBiyLdTuDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EZwwlNOvSvl+rKT7a1ceC832qWXYL65iR/7ilzgvcuI=;
        b=TVwkMhy1o9Oc/Ycd4YwtljfiUPLtmlC6w9MkNiVgDWWuRBT2Dcw26VcWv+1ByxxWMb
         lZ+7dQuDiG+H4Z063z3u+yPThCZmxoZgy7/JorOjH91Fdo+U+KzoQA+5zgeuvIT+fm+A
         fsBLUTdILg04zNmP2xYdJR0+vBr7Zp8JATNfQcBFmzmnV9aL6ZN9LKChne9S9gMShjGi
         A4qTSzpshwuxXF7UpNa38ozoEXS70qFheoXf4Os5kAebCPKfgQI0dZiFROtJaDAzqJIL
         upXp525/64x/VGECk89znY82RJ+MvqA23SttvvoY075hRwgeSNvdJyzO+YFI4YL5uZMd
         tEvA==
X-Gm-Message-State: APjAAAX+L55AUhNXOD2Ewt53zSqklsTVLp6EcxEfdKdGbX1PsBzmErkl
        Z914aSnDa26R9TK9E1OXaB45zA==
X-Google-Smtp-Source: APXvYqw0A9Zkxe5CxmM+U8CeA/IPxBqdsxs3e8LiPQgrndSz0Cnq2Fc6BrACe0bbzLbKra6G+57Eww==
X-Received: by 2002:adf:e3d0:: with SMTP id k16mr85755629wrm.241.1577996078295;
        Thu, 02 Jan 2020 12:14:38 -0800 (PST)
Received: from localhost ([2620:10d:c092:200::1:3256])
        by smtp.gmail.com with ESMTPSA id w8sm8496806wmd.2.2020.01.02.12.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 12:14:37 -0800 (PST)
Date:   Thu, 2 Jan 2020 20:14:37 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH v2 2/2] tmpfs: Support 64-bit inums per-sb
Message-ID: <20200102201437.GB1181932@chrisdown.name>
References: <cover.1577990599.git.chris@chrisdown.name>
 <34a170550a77c77ad7b6fdca86847ae7fd35d761.1577990599.git.chris@chrisdown.name>
 <CAOQ4uxg_V_TCPrOZdF2gkGgmnqeWaamABSyVp8Prx6Y+=WdLBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg_V_TCPrOZdF2gkGgmnqeWaamABSyVp8Prx6Y+=WdLBg@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein writes:
>> +config TMPFS_INODE64
>> +       bool "Use 64-bit ino_t by default in tmpfs"
>> +       depends on TMPFS && 64BIT
>> +       default n
>> +       help
>> +         tmpfs has historically used only inode numbers as wide as an unsigned
>> +         int. In some cases this can cause wraparound, potentially resulting in
>> +         multiple files with the same inode number on a single device. This option
>> +         makes tmpfs use the full width of ino_t by default, similarly to the
>> +         inode64 mount option.
>> +
>> +         tmpfs mounts that are used privately by the kernel and are not visible to
>> +         users are unaffected.
>
>Admins won't know what the line above means and they shouldn't care.
>It adds no information, so better remove it.

Sure thing.

>> +
>> +       /*
>> +        * Showing inode{64,32} might be useful even if it's the system default,
>> +        * since then people don't have to resort to checking both here and
>> +        * /proc/config.gz to confirm 64-bit inums were successfully applied
>> +        * (which may not even exist if IKCONFIG_PROC isn't enabled).
>> +        *
>> +        * We hide it when inode64 isn't the default and we are using 32-bit
>> +        * inodes, since that probably just means the feature isn't even under
>> +        * consideration.
>> +        *
>> +        * As such:
>> +        *
>> +        *                     +-----------------+-----------------+
>> +        *                     | TMPFS_INODE64=y | TMPFS_INODE64=n |
>> +        *  +------------------+-----------------+-----------------+
>> +        *  | full_inums=true  | show            | show            |
>> +        *  | full_inums=false | show            | hide            |
>> +        *  +------------------+-----------------+-----------------+
>> +        *
>> +        */
>> +       if (IS_ENABLED(CONFIG_TMPFS_INODE64) || !sbinfo->full_inums)
>
>Condition does not match comment - should be || sbinfo->full_inums)

Good catch! Thanks.

>> @@ -3915,6 +3969,7 @@ int shmem_init_fs_context(struct fs_context *fc)
>>         ctx->mode = 0777 | S_ISVTX;
>>         ctx->uid = current_fsuid();
>>         ctx->gid = current_fsgid();
>> +       ctx->full_inums = IS_ENABLED(CONFIG_TMPFS_INODE64);
>>
>
>This is the wrong place for this - it is also being set for the kern_mount.
>Follow the lead of shmem_default_max_inodes.

Hmm, full_inums is intended to be simply ignored for SB_KERNMOUNT though, so it 
seems harmless, but I agree maybe it makes the intent of the code clearer to 
move it to a more specific place.

Thanks! I'll fix these up for v3.
