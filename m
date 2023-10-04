Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8958B7B8DBA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 21:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244241AbjJDT4c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 15:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243968AbjJDT41 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:56:27 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8871A6;
        Wed,  4 Oct 2023 12:56:22 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-77432add7caso12643685a.2;
        Wed, 04 Oct 2023 12:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696449382; x=1697054182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sGTZeR8rqqUgXP+mUWxeR7U93m1cwe4O1CklupLq00I=;
        b=ZrEF8gzQ7lPKFdFwyeIUUMDULQKChJZQr4et9BO/YFtrEjrZ6Ge36etev0i9t7c4Qa
         TVfSVqUavVpqSQqd4LBQv5DnCtdq4ZL4Pb9Es7z93VtsYZQOuF0YWPSSvuTcttenttOL
         BrkvFHxVN1la58G+eIM0qn38zrpXfRRp2oBP0NRmdCW0bo6BeN4U/CofsjWbTIJ5sZL4
         oB4jqniyohatIU9NCEHuTfiXWCJuV5fJ6HQDT3hGy5bvwDYepEPRlHJx6SyH1X6aD3H8
         cCnH7vrG7lTX2lypyry2c7OSbzBK9EcHN6vWqF6rTFh2cPBYohGyhSt3su96pd+6JCk2
         blXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696449382; x=1697054182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGTZeR8rqqUgXP+mUWxeR7U93m1cwe4O1CklupLq00I=;
        b=dOmFFmaVQ0GcHNnL2l/OTXSztcVcEaE8/jkxRVrLc0pyyjJwAPO9acSTvhpaG0yjrE
         A9PdUQU6Y1zJR4BRQLo57BgS7Gmzcpkhko6qc9hKLLJdF8j6YGj284+O3arhQxl5z5ld
         KHNFXhgejKOUzV2pCQ2N+DEGlJNKLAFrp1R+MOxZ8oZ73AHBL7MKheWAewHchA1MpRZM
         EIu28LUz+c+GpHnyt1DSDmDBQgwwYRzXIg8NsL4UIAymzWNKyXF9WHeUua4AJDZhyOhu
         H6q9QKA+4qT4XXc9aS+3iUwWwscf+mbRGHKwgtFTt2n0zEM2YcWsgTqZqeh8On8EGx3V
         KXBw==
X-Gm-Message-State: AOJu0YyUfX1MG/IHPrgTqRtD37+WDbHyyPJA2VIohJEfjpqA/2L7x2lS
        89pEVmxB32YwzDJabDA9uCiiDL4gCg8=
X-Google-Smtp-Source: AGHT+IHti+jOTEFYUA6WTBB0ttRuejAfdXHrjp8fgloLZ0vErV5sMsvrcpQMn2Op+7c4+ivB7/TjlA==
X-Received: by 2002:a05:620a:4483:b0:774:16fc:65eb with SMTP id x3-20020a05620a448300b0077416fc65ebmr3668419qkp.4.1696449381737;
        Wed, 04 Oct 2023 12:56:21 -0700 (PDT)
Received: from debian-BULLSEYE-live-builder-AMD64 (h64-35-202-119.cntcnh.broadband.dynamic.tds.net. [64.35.202.119])
        by smtp.gmail.com with ESMTPSA id d1-20020a05620a140100b0076dacd14484sm1500916qkj.83.2023.10.04.12.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 12:56:21 -0700 (PDT)
Date:   Wed, 4 Oct 2023 15:56:19 -0400
From:   Eric Whitney <enwlinux@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Eric Whitney <enwlinux@gmail.com>, linux-ext4@vger.kernel.org,
        libaokun1@huawei.com, linux-fsdevel@vger.kernel.org
Subject: Re: probable quota bug introduced in 6.6-rc1
Message-ID: <ZR3DY733/uZ86rAG@debian-BULLSEYE-live-builder-AMD64>
References: <ZRytn6CxFK2oECUt@debian-BULLSEYE-live-builder-AMD64>
 <20231004150019.j2nebmxoa7zttu4x@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004150019.j2nebmxoa7zttu4x@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Jan Kara <jack@suse.cz>:
> On Tue 03-10-23 20:11:11, Eric Whitney wrote:
> > When run on my test hardware, generic/270 triggers hung task timeouts when
> > run on a 6.6-rc1 (or -rc2, -rc3, -rc4) kernel with kvm-xfstests using the
> > nojournal test scenario.  The test always passes, but about 60% of the time
> > the running time of the test increases by an order of magnitude or more and
> > one or more of the hung task timeout warnings included below can be found in
> > the log.
> > 
> > This does not reproduce on 6.5.  Bisection leads to this patch:
> > 
> > dabc8b207566 ("quota: fix dqput() to follow the guarantees dquot_srcu should
> > provide")
> 
> Thanks for report! Indeed I can reproduce this. Attached patch fixes the
> problem for me, I'll queue it up in my tree once it passes some more
> testing.
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

Hi Jan:

Thanks very much for the quick work - I ran 100 trials of generic/270 on
the nojournal test scenario using a patched 6.6-rc1 kernel and didn't see any
hung task timeouts.  The elapsed test runtimes are comparable to those I get
when running on 6.5 using the same test hardware. So, your patch works for me.

Eric

> From cc557f91af0a970e731e3dc945a431271e59ce8c Mon Sep 17 00:00:00 2001
> From: Jan Kara <jack@suse.cz>
> Date: Wed, 4 Oct 2023 15:32:01 +0200
> Subject: [PATCH] quota: Fix slow quotaoff
> 
> Eric has reported that commit dabc8b207566 ("quota: fix dqput() to
> follow the guarantees dquot_srcu should provide") heavily increases
> runtime of generic/270 xfstest for ext4 in nojournal mode. The reason
> for this is that ext4 in nojournal mode leaves dquots dirty until the last
> dqput() and thus the cleanup done in quota_release_workfn() has to write
> them all. Due to the way quota_release_workfn() is written this results
> in synchronize_srcu() call for each dirty dquot which makes the dquot
> cleanup when turning quotas off extremely slow.
> 
> To be able to avoid synchronize_srcu() for each dirty dquot we need to
> rework how we track dquots to be cleaned up. Instead of keeping the last
> dquot reference while it is on releasing_dquots list, we drop it right
> away and mark the dquot with new DQ_RELEASING_B bit instead. This way we
> can we can remove dquot from releasing_dquots list when new reference to
> it is acquired and thus there's no need to call synchronize_srcu() each
> time we drop dq_list_lock.
> 
> References: https://lore.kernel.org/all/ZRytn6CxFK2oECUt@debian-BULLSEYE-live-builder-AMD64
> Reported-by: Eric Whitney <enwlinux@gmail.com>
> Fixes: dabc8b207566 ("quota: fix dqput() to follow the guarantees dquot_srcu should provide")
> CC: stable@vger.kernel.org
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/quota/dquot.c         | 59 ++++++++++++++++++++++------------------
>  include/linux/quota.h    |  4 ++-
>  include/linux/quotaops.h |  2 +-
>  3 files changed, 36 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index 9e72bfe8bbad..f4df2420e59c 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -233,19 +233,18 @@ static void put_quota_format(struct quota_format_type *fmt)
>   * All dquots are placed to the end of inuse_list when first created, and this
>   * list is used for invalidate operation, which must look at every dquot.
>   *
> - * When the last reference of a dquot will be dropped, the dquot will be
> - * added to releasing_dquots. We'd then queue work item which would call
> + * When the last reference of a dquot is dropped, the dquot is added to
> + * releasing_dquots. We'll then queue work item which will call
>   * synchronize_srcu() and after that perform the final cleanup of all the
> - * dquots on the list. Both releasing_dquots and free_dquots use the
> - * dq_free list_head in the dquot struct. When a dquot is removed from
> - * releasing_dquots, a reference count is always subtracted, and if
> - * dq_count == 0 at that point, the dquot will be added to the free_dquots.
> + * dquots on the list. Each cleaned up dquot is moved to free_dquots list.
> + * Both releasing_dquots and free_dquots use the dq_free list_head in the dquot
> + * struct.
>   *
> - * Unused dquots (dq_count == 0) are added to the free_dquots list when freed,
> - * and this list is searched whenever we need an available dquot.  Dquots are
> - * removed from the list as soon as they are used again, and
> - * dqstats.free_dquots gives the number of dquots on the list. When
> - * dquot is invalidated it's completely released from memory.
> + * Unused and cleaned up dquots are in the free_dquots list and this list is
> + * searched whenever we need an available dquot. Dquots are removed from the
> + * list as soon as they are used again and dqstats.free_dquots gives the number
> + * of dquots on the list. When dquot is invalidated it's completely released
> + * from memory.
>   *
>   * Dirty dquots are added to the dqi_dirty_list of quota_info when mark
>   * dirtied, and this list is searched when writing dirty dquots back to
> @@ -321,6 +320,7 @@ static inline void put_dquot_last(struct dquot *dquot)
>  static inline void put_releasing_dquots(struct dquot *dquot)
>  {
>  	list_add_tail(&dquot->dq_free, &releasing_dquots);
> +	set_bit(DQ_RELEASING_B, &dquot->dq_flags);
>  }
>  
>  static inline void remove_free_dquot(struct dquot *dquot)
> @@ -328,8 +328,10 @@ static inline void remove_free_dquot(struct dquot *dquot)
>  	if (list_empty(&dquot->dq_free))
>  		return;
>  	list_del_init(&dquot->dq_free);
> -	if (!atomic_read(&dquot->dq_count))
> +	if (!test_bit(DQ_RELEASING_B, &dquot->dq_flags))
>  		dqstats_dec(DQST_FREE_DQUOTS);
> +	else
> +		clear_bit(DQ_RELEASING_B, &dquot->dq_flags);
>  }
>  
>  static inline void put_inuse(struct dquot *dquot)
> @@ -581,12 +583,6 @@ static void invalidate_dquots(struct super_block *sb, int type)
>  			continue;
>  		/* Wait for dquot users */
>  		if (atomic_read(&dquot->dq_count)) {
> -			/* dquot in releasing_dquots, flush and retry */
> -			if (!list_empty(&dquot->dq_free)) {
> -				spin_unlock(&dq_list_lock);
> -				goto restart;
> -			}
> -
>  			atomic_inc(&dquot->dq_count);
>  			spin_unlock(&dq_list_lock);
>  			/*
> @@ -605,6 +601,15 @@ static void invalidate_dquots(struct super_block *sb, int type)
>  			 * restart. */
>  			goto restart;
>  		}
> +		/*
> +		 * The last user already dropped its reference but dquot didn't
> +		 * get fully cleaned up yet. Restart the scan which flushes the
> +		 * work cleaning up released dquots.
> +		 */
> +		if (test_bit(DQ_RELEASING_B, &dquot->dq_flags)) {
> +			spin_unlock(&dq_list_lock);
> +			goto restart;
> +		}
>  		/*
>  		 * Quota now has no users and it has been written on last
>  		 * dqput()
> @@ -809,18 +814,18 @@ static void quota_release_workfn(struct work_struct *work)
>  	/* Exchange the list head to avoid livelock. */
>  	list_replace_init(&releasing_dquots, &rls_head);
>  	spin_unlock(&dq_list_lock);
> +	synchronize_srcu(&dquot_srcu);
>  
>  restart:
> -	synchronize_srcu(&dquot_srcu);
>  	spin_lock(&dq_list_lock);
>  	while (!list_empty(&rls_head)) {
>  		dquot = list_first_entry(&rls_head, struct dquot, dq_free);
> -		/* Dquot got used again? */
> -		if (atomic_read(&dquot->dq_count) > 1) {
> -			remove_free_dquot(dquot);
> -			atomic_dec(&dquot->dq_count);
> -			continue;
> -		}
> +		WARN_ON_ONCE(atomic_read(&dquot->dq_count));
> +		/*
> +		 * Note that DQ_RELEASING_B protects us from racing with
> +		 * invalidate_dquots() calls so we are safe to work with the
> +		 * dquot even after we drop dq_list_lock.
> +		 */
>  		if (dquot_dirty(dquot)) {
>  			spin_unlock(&dq_list_lock);
>  			/* Commit dquot before releasing */
> @@ -834,7 +839,6 @@ static void quota_release_workfn(struct work_struct *work)
>  		}
>  		/* Dquot is inactive and clean, now move it to free list */
>  		remove_free_dquot(dquot);
> -		atomic_dec(&dquot->dq_count);
>  		put_dquot_last(dquot);
>  	}
>  	spin_unlock(&dq_list_lock);
> @@ -875,6 +879,7 @@ void dqput(struct dquot *dquot)
>  	BUG_ON(!list_empty(&dquot->dq_free));
>  #endif
>  	put_releasing_dquots(dquot);
> +	atomic_dec(&dquot->dq_count);
>  	spin_unlock(&dq_list_lock);
>  	queue_delayed_work(system_unbound_wq, &quota_release_work, 1);
>  }
> @@ -963,7 +968,7 @@ struct dquot *dqget(struct super_block *sb, struct kqid qid)
>  		dqstats_inc(DQST_LOOKUPS);
>  	}
>  	/* Wait for dq_lock - after this we know that either dquot_release() is
> -	 * already finished or it will be canceled due to dq_count > 1 test */
> +	 * already finished or it will be canceled due to dq_count > 0 test */
>  	wait_on_dquot(dquot);
>  	/* Read the dquot / allocate space in quota file */
>  	if (!dquot_active(dquot)) {
> diff --git a/include/linux/quota.h b/include/linux/quota.h
> index fd692b4a41d5..07071e64abf3 100644
> --- a/include/linux/quota.h
> +++ b/include/linux/quota.h
> @@ -285,7 +285,9 @@ static inline void dqstats_dec(unsigned int type)
>  #define DQ_FAKE_B	3	/* no limits only usage */
>  #define DQ_READ_B	4	/* dquot was read into memory */
>  #define DQ_ACTIVE_B	5	/* dquot is active (dquot_release not called) */
> -#define DQ_LASTSET_B	6	/* Following 6 bits (see QIF_) are reserved\
> +#define DQ_RELEASING_B	6	/* dquot is in releasing_dquots list waiting
> +				 * to be cleaned up */
> +#define DQ_LASTSET_B	7	/* Following 6 bits (see QIF_) are reserved\
>  				 * for the mask of entries set via SETQUOTA\
>  				 * quotactl. They are set under dq_data_lock\
>  				 * and the quota format handling dquot can\
> diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
> index 11a4becff3a9..4fa4ef0a173a 100644
> --- a/include/linux/quotaops.h
> +++ b/include/linux/quotaops.h
> @@ -57,7 +57,7 @@ static inline bool dquot_is_busy(struct dquot *dquot)
>  {
>  	if (test_bit(DQ_MOD_B, &dquot->dq_flags))
>  		return true;
> -	if (atomic_read(&dquot->dq_count) > 1)
> +	if (atomic_read(&dquot->dq_count) > 0)
>  		return true;
>  	return false;
>  }
> -- 
> 2.35.3
> 

