Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB1A2E8EB4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Jan 2021 23:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbhACWsV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jan 2021 17:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbhACWsU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jan 2021 17:48:20 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD10C061573;
        Sun,  3 Jan 2021 14:47:40 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id y19so60206913lfa.13;
        Sun, 03 Jan 2021 14:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=87RUIw64Kr1A5OliwMJO/pfdIRcRUQAtOYF9J54FhFc=;
        b=R/1h1w3CLjy283V6oGtpIoG1Q3tLeo2fn53+eC1YwCEqKLEFXFGLAqt8u+HgEcM2y2
         pDJw2mk8uRs2GlW/WHf2OJNXPkE5rggyNItKfJKVA0kqq5qbiRWFJrOmQ15FEPE+iDRU
         TE5q6RPjuuHIXzV7C0yJ91mjOy+/R7ZOTc/847mTrDZrObKDo3D4yx6/vqKXl2FUXAky
         6tZ/n2T+UIgCBkFxqwQT/DLnmokz9lkteidCq9xlzSoX2Z8kVdjMpSs7y/SCC00TYjyi
         hxnYNMuBdxJ1rzw0xmj8jA/g4pdH/eL/nxULesRToDb6X3S4Xc06jhiwEpAyT4EOQKTl
         yXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=87RUIw64Kr1A5OliwMJO/pfdIRcRUQAtOYF9J54FhFc=;
        b=CANhiv4TgnF/liBvpOGPLVDVr2599jZ0tnaH6MO8dTXJl/gKLV2sDfpTbjPKqgOlPk
         S1YAIBoXnP7TWECHt8Gr12IifUllFl2JivvtUAbQNO0wTZJObeRHCohZt8NEBs3eLbLz
         rhZyD1NOGhNsWzQmv7BUWEgCP7NWDnLaOplhmuALyuT/pQ2Nim2MDb/9A3jSZ8Egfje3
         ontszsfvStHvAlXGHYqi0od1cCo69ZR5tGZ3BEbKmtrGyXYVpboWtK8SwgPhBw230gj3
         bVR1hpcUEufwWWutNRCX7U66VqjRLSybPNSsngyNsOU6xXtOyyGf98c+h9GCxbBPG3/O
         WISg==
X-Gm-Message-State: AOAM530tbtC5vo4kO0cHp2kUo5LiGWmKT2kAsaLSmt0v7zlD+gfogWPi
        zxVxGVitk1In5tzkGT7wDEs=
X-Google-Smtp-Source: ABdhPJxgZE7Fua+oorVTutxvrhFL61TMXKPZjfQDeihCiOf41/1uIS8p4sX7RhggqGKOwgIFs0bGzw==
X-Received: by 2002:a2e:909a:: with SMTP id l26mr33223108ljg.182.1609714058543;
        Sun, 03 Jan 2021 14:47:38 -0800 (PST)
Received: from kari-VirtualBox (87-95-193-210.bb.dnainternet.fi. [87.95.193.210])
        by smtp.gmail.com with ESMTPSA id k11sm7095916lfd.3.2021.01.03.14.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 14:47:37 -0800 (PST)
Date:   Mon, 4 Jan 2021 00:47:35 +0200
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, willy@infradead.org, rdunlap@infradead.org,
        joe@perches.com, mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com
Subject: Re: [PATCH v17 07/10] fs/ntfs3: Add NTFS journal
Message-ID: <20210103224735.gtirbmcpkdsietrl@kari-VirtualBox>
References: <20201231152401.3162425-1-almaz.alexandrovich@paragon-software.com>
 <20201231152401.3162425-8-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201231152401.3162425-8-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 31, 2020 at 06:23:58PM +0300, Konstantin Komarov wrote:
> This adds NTFS journal
> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>  fs/ntfs3/fslog.c | 5220 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 5220 insertions(+)
>  create mode 100644 fs/ntfs3/fslog.c
> 
> diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c

> +static int read_log_page(struct ntfs_log *log, u32 vbo,
> +			 struct RECORD_PAGE_HDR **buffer, bool allow_errors,
> +			 bool ignore_usa_error, bool *usa_error)

Allow_errors does nothing. I also think that no need for
ignore_usa_error. We can just check usa_error if we need
it. We just never raise return error for usa_error. And
then caller can decide if want's to use it. 

> +{
> +	int err = 0;
> +	u32 page_idx = vbo >> log->page_bits;
> +	u32 page_off = vbo & log->page_mask;
> +	u32 bytes = log->page_size - page_off;
> +	void *to_free = NULL;
> +	u32 page_vbo = page_idx << log->page_bits;
> +	struct RECORD_PAGE_HDR *page_buf;
> +	struct ntfs_inode *ni = log->ni;
> +	bool bBAAD;
> +
> +	if (vbo >= log->l_size)
> +		return -EINVAL;
> +
> +	if (!*buffer) {
> +		to_free = ntfs_alloc(bytes, 0);
> +		if (!to_free)
> +			return -ENOMEM;
> +		*buffer = to_free;
> +	}
> +
> +	page_buf = page_off ? log->one_page_buf : *buffer;
> +
> +	err = ntfs_read_run_nb(ni->mi.sbi, &ni->file.run, page_vbo, page_buf,
> +			       log->page_size, NULL);
> +	if (err)
> +		goto out;
> +
> +	if (page_buf->rhdr.sign != NTFS_FFFF_SIGNATURE)
> +		ntfs_fix_post_read(&page_buf->rhdr, PAGE_SIZE, false);
> +
> +	if (page_buf != *buffer)
> +		memcpy(*buffer, Add2Ptr(page_buf, page_off), bytes);
> +
> +	bBAAD = page_buf->rhdr.sign == NTFS_BAAD_SIGNATURE;
> +
> +	/* Check that the update sequence array for this page is valid */
> +	if (bBAAD) {
> +		/* If we don't allow errors, raise an error status */
> +		if (!ignore_usa_error) {
> +			err = -EINVAL;
> +			goto out;
> +		}
> +	}
> +
> +	if (usa_error)
> +		*usa_error = bBAAD;
> +

So here we can just
	delete if(bBAAD)
and use
	if (usa_error)
		*usa_error = page_buf->rhdr.sign == NTFS_BAAD_SIGNATURE;

> +out:
> +	if (err && to_free) {
> +		ntfs_free(to_free);
> +		*buffer = NULL;
> +	}
> +
> +	return err;
> +}

> +/*
> + * last_log_lsn
> + *
> + * This routine walks through the log pages for a file, searching for the
> + * last log page written to the file
> + */
> +static int last_log_lsn(struct ntfs_log *log)
> +{

> +	struct RECORD_PAGE_HDR *first_tail = NULL;
> +	struct RECORD_PAGE_HDR *second_tail = NULL;

> +next_tail:
> +	/* Read second tail page (at pos 3/0x12000) */
> +	if (read_log_page(log, second_off, &second_tail, true, true,
> +			  &usa_error) ||
> +	    usa_error || second_tail->rhdr.sign != NTFS_RCRD_SIGNATURE) {
> +		ntfs_free(second_tail);
> +		second_tail = NULL;
> +		second_file_off = 0;
> +		lsn2 = 0;
> +	} else {
> +		second_file_off = hdr_file_off(log, second_tail);
> +		lsn2 = le64_to_cpu(second_tail->record_hdr.last_end_lsn);
> +	}

What will happend if we get -ENOMEM from read_log_page(). Log page
might still be valid we will just ignore it. This doesn't sound 
right. 

This same thing happens many place with read_log_page().

> +
> +	/* Read first tail page (at pos 2/0x2000 ) */
> +	if (read_log_page(log, final_off, &first_tail, true, true,
> +			  &usa_error) ||
> +	    usa_error || first_tail->rhdr.sign != NTFS_RCRD_SIGNATURE) {
> +		ntfs_free(first_tail);
> +		first_tail = NULL;
> +		first_file_off = 0;
> +		lsn1 = 0;
> +	} else {
> +		first_file_off = hdr_file_off(log, first_tail);
> +		lsn1 = le64_to_cpu(first_tail->record_hdr.last_end_lsn);
> +	}

> +	if (first_tail && second_tail) {
> +		if (best_lsn1 > best_lsn2) {
> +			best_lsn = best_lsn1;
> +			best_page = first_tail;
> +			this_off = first_file_off;
> +		} else {
> +			best_lsn = best_lsn2;
> +			best_page = second_tail;
> +			this_off = second_file_off;
> +		}
> +	} else if (first_tail) {
> +		best_lsn = best_lsn1;
> +		best_page = first_tail;
> +		this_off = first_file_off;
> +	} else if (second_tail) {
> +		best_lsn = best_lsn2;
> +		best_page = second_tail;
> +		this_off = second_file_off;
> +	} else {
> +		goto free_and_tail_read;

Can't we just use straight tail_read here? 

> +	}
> +
> +	best_page_pos = le16_to_cpu(best_page->page_pos);

> +	} else {
> +free_and_tail_read:
> +		ntfs_free(first_tail);
> +		ntfs_free(second_tail);
> +		goto tail_read;
> +	}
> +
> +	ntfs_free(first_tail_prev);
> +	first_tail_prev = first_tail;
> +	final_off_prev = first_file_off;
> +	first_tail = NULL;
> +
> +	ntfs_free(second_tail_prev);
> +	second_tail_prev = second_tail;
> +	second_off_prev = second_file_off;
> +	second_tail = NULL;
> +
> +	final_off += log->page_size;
> +	second_off += log->page_size;
> +
> +	if (tails < 0x10)
> +		goto next_tail;
> +tail_read:
> +	first_tail = first_tail_prev;
> +	final_off = final_off_prev;

> +int log_replay(struct ntfs_inode *ni)
> +{

> +	/* Now we need to walk through looking for the last lsn */
> +	err = last_log_lsn(log);
> +	if (err == -EROFS)
> +		goto out;
> +

No need for this if below is whole err check.

> +	if (err)
> +		goto out;
 
