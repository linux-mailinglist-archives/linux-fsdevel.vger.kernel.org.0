Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D787D73601E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 01:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjFSX2K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 19:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjFSX1w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 19:27:52 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D7D1982
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jun 2023 16:25:08 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-666e916b880so1529839b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jun 2023 16:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1687217108; x=1689809108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nq8ZwPfadoIy5gd1Fgjrv5Py55QScCrFH6K7CQ++xtI=;
        b=xN4bbnyrWS/7pssMWn96NGcXWGQktdo3DzHJxASULdo3PHyslzoEamSjbGffn+W4y6
         UL4qiNRc99Trl5UcFLfmpELCKF5JMBRe4JZ6xjp5UGWpEH+83387J3LDlauIcjhfZ/iY
         uYUa96gMb9M1D/B1B2gRbcoxfmmPB8YZa8nC8d49W/J9gdIT+Se/HKp0e3ZKPJnwcF9m
         XuEgK3ZKi95P0Vbro1gru0BjjuBwxbzL+SsVUhvbZ59BrNKFQ+XWSv8DELLWE6B5K9i/
         w5+MvkwOm3rKflpGoMaKBH3SX1V4DT0YQmavzHYLVlXRR6Il2hMQSxbGx5xcPurCTEbQ
         +6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687217108; x=1689809108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nq8ZwPfadoIy5gd1Fgjrv5Py55QScCrFH6K7CQ++xtI=;
        b=BSWTtvUmCroCM8zBk/DUw3JBzGPMI38gdb4sQVMqxaOi2HZWYyulwS4kijhY621fTe
         j4vgziMc2Fym2RBiVPtwV2HmbVSn4JjAT676KSBjfysr1vPD5RwIVN9u0HxLX2b1FjBn
         BhyGy6DQKK/UtB/thl/v0xP3v71O26/OctN26WiNDQKrtmpJ8zxT0ZCruBNO3LUKyj+7
         N2zRMD/IWWd5CTCdUVBJ0lSMlIID27ZNUYPff31LS8UiXCSZmAS1emHSPQN7ELNXujjP
         hBkeZq9HPGhgT2ZXa3Q96uNS2hv9AaCo5ek5Ax9LfJELRF0Ihu6nH41b5nDuTsYLuApn
         cdag==
X-Gm-Message-State: AC+VfDxlAM6tFV1wogTJ+yKqu+PPbVXpVcV6as2+0S33CNNTpt3rZmvp
        +sk7BJgT40d4RcJPVf1Z35X6FA==
X-Google-Smtp-Source: ACHHUZ5dDxjGCeD+SuVwpsSgcKKxcwUvzIoxiIzQylwE228kmeoZyMGQKQlwJbTy1rXIVM8O/mO1pg==
X-Received: by 2002:a05:6a20:7295:b0:115:a2f4:6284 with SMTP id o21-20020a056a20729500b00115a2f46284mr1903473pzk.16.1687217107705;
        Mon, 19 Jun 2023 16:25:07 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id z11-20020a170903018b00b001a072aedec7sm328346plg.75.2023.06.19.16.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 16:25:07 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qBOF7-00Dpof-02;
        Tue, 20 Jun 2023 09:25:05 +1000
Date:   Tue, 20 Jun 2023 09:25:05 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2] fs: Provide helpers for manipulating
 sb->s_readonly_remount
Message-ID: <ZJDj0XjkeVK7AHIx@dread.disaster.area>
References: <20230619111832.3886-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619111832.3886-1-jack@suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 19, 2023 at 01:18:32PM +0200, Jan Kara wrote:
> Provide helpers to set and clear sb->s_readonly_remount including
> appropriate memory barriers. Also use this opportunity to document what
> the barriers pair with and why they are needed.
> 
> Suggested-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/internal.h      | 34 ++++++++++++++++++++++++++++++++++
>  fs/namespace.c     | 10 ++++------
>  fs/super.c         | 17 ++++++-----------
>  include/linux/fs.h |  2 +-
>  4 files changed, 45 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/internal.h b/fs/internal.h
> index bd3b2810a36b..e206eb58bd3e 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -120,6 +120,40 @@ void put_super(struct super_block *sb);
>  extern bool mount_capable(struct fs_context *);
>  int sb_init_dio_done_wq(struct super_block *sb);
>  
> +/*
> + * Prepare superblock for changing its read-only state (i.e., either remount
> + * read-write superblock read-only or vice versa). After this function returns
> + * mnt_is_readonly() will return true for any mount of the superblock if its
> + * caller is able to observe any changes done by the remount. This holds until
> + * sb_end_ro_state_change() is called.
> + */
> +static inline void sb_start_ro_state_change(struct super_block *sb)
> +{
> +	WRITE_ONCE(sb->s_readonly_remount, 1);
> +	/*
> +	 * For RO->RW transition, the barrier pairs with the barrier in
> +	 * mnt_is_readonly() making sure if mnt_is_readonly() sees SB_RDONLY
> +	 * cleared, it will see s_readonly_remount set.
> +	 * For RW->RO transition, the barrier pairs with the barrier in
> +	 * __mnt_want_write() before the mnt_is_readonly() check. The barrier
> +	 * makes sure if __mnt_want_write() sees MNT_WRITE_HOLD already
> +	 * cleared, it will see s_readonly_remount set.
> +	 */
> +	smp_wmb();
> +}

Can you please also update mnt_is_readonly/__mnt_want_write to
indicate that there is a pairing with this helper from those
functions?

> +
> +/*
> + * Ends section changing read-only state of the superblock. After this function
> + * returns if mnt_is_readonly() returns false, the caller will be able to
> + * observe all the changes remount did to the superblock.
> + */
> +static inline void sb_end_ro_state_change(struct super_block *sb)
> +{
> +	/* The barrier pairs with the barrier in mnt_is_readonly() */
> +	smp_wmb();
> +	WRITE_ONCE(sb->s_readonly_remount, 0);
> +}

	/*
	 * This barrier provides release semantics that pair with
	 * the smp_rmb() acquire semantics in mnt_is_readonly().
	 * This barrier pair ensure that when mnt_is_readonly() sees
	 * 0 for sb->s_readonly_remount, it will also see all the
	 * preceding flag changes that were made during the RO state
	 * change.
	 */

And a comment in mnt_is_readonly() to indicate that it also pairs
with sb_end_ro_state_change() in a different way to the barriers in
sb_start_ro_state_change(), __mnt_want_write(), MNT_WRITE_HOLD, etc.

Memory barriers need clear, concise documentation, otherwise they
are impossible to understand from just reading the code...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
