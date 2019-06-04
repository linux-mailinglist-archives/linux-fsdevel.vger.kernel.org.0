Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB29D34947
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2019 15:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfFDNq2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jun 2019 09:46:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36091 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfFDNq2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:46:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so12868055wrs.3;
        Tue, 04 Jun 2019 06:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=BdJYLZrrSWJNT4lfUWGV9fqHUaCf6Pcc9zbBPoLUgkk=;
        b=ibD43TNmQVoGey9FPCc9C1K7dD/Fxum/wxfrphIGryulQ2P44yVWPqFcoRR06Rk1EP
         FZKXT+F8LcrkIQt+e0g+zZtzYLELnTOUpQTjWdYO8xLM2m+ZzVXDEYvrieEQ5fSqMVJV
         nI0sWUhiv8fRHUoK8Yxe1yP2SigpKf6Y8RbN9MVBFDJeh0K7nayaaFRtFt/aiGVUQgUX
         jUhHCaz22i9tIgJodIWRynBfED+y86fXzCsQuiGoAlUfhBKzfAUcRjiZzrQSNSLpYArT
         7X+7HkEbNEdm6GSgwqXAGh37xYO/PW3KiqD4Hnb7uMKEqO1zMSPGCGnbA3t6A7iuJ45m
         ayZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=BdJYLZrrSWJNT4lfUWGV9fqHUaCf6Pcc9zbBPoLUgkk=;
        b=rcDjgBl0LKCG86kOu00V5FYJFEd7KGISRBFrwlKYw9DMq6rpbxofGeGF88MDkojoBh
         5tQXc0a+ROcJwVSUzyoQJPEztrA0sP8hcEHyS8QBa0A05yBIdNSkCwv3ElxfejacBvC0
         hD1FCbJN5Xw87JQ4jhyxhDMGsRnR+E8sYWDsMen2OyrBetuKdr+krJpgbw4Bxx2LExhJ
         ncBn+9FTr4qajLHVpoLbo/8XGYSmoY0vWQ1VP9uHy+cetanNrvLNLc2oMfSU/DfSD4mU
         iGhv5EIfO38WIxO9uk7csNAiaHYu4DoPp8mNRZGDNTjVc/DUFH8QFCOg7vLM8lR222Rg
         EHEA==
X-Gm-Message-State: APjAAAXUQzaPWeBj9xxteO3S1F4/FqeP56WyYo8ckYl7qyd1UaY04T/b
        IAljHzVGFbgRVYMVTxzTihL0t31p
X-Google-Smtp-Source: APXvYqxdxaFPLf3Lo2yUH5EBfNAqFC8EG2jh/+kRhb3z/97TrAggjd2w5A7D9BgFwpOJniOrgbe89w==
X-Received: by 2002:a05:6000:10c2:: with SMTP id b2mr7895458wrx.57.1559655986210;
        Tue, 04 Jun 2019 06:46:26 -0700 (PDT)
Received: from [172.16.8.139] (host-78-151-217-120.as13285.net. [78.151.217.120])
        by smtp.gmail.com with ESMTPSA id f20sm13034887wmh.22.2019.06.04.06.46.24
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 06:46:25 -0700 (PDT)
Subject: Re: understanding xfs vs. ext4 log performance
To:     Lucas Stach <dev@lynxeye.de>, linux-xfs@vger.kernel.org
References: <7a642f570980609ccff126a78f1546265ba913e2.camel@lynxeye.de>
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Message-ID: <e3721341-2ea0-f13f-ae42-890209736eaa@gmail.com>
Date:   Tue, 4 Jun 2019 14:46:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7a642f570980609ccff126a78f1546265ba913e2.camel@lynxeye.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04/06/2019 10:21, Lucas Stach wrote:
> Hi all,
>
> this question is more out of curiosity and because I want to take the
> chance to learn something.
>
> At work we've stumbled over a workload that seems to hit pathological
> performance on XFS. Basically the critical part of the workload is a
> "rm -rf" of a pretty large directory tree, filled with files of mixed
> size ranging from a few KB to a few MB. The filesystem resides on quite
> slow spinning rust disks, directly attached to the host, so no
> controller with a BBU or something like that involved.
>
> We've tested the workload with both xfs and ext4, and while the numbers
> aren't completely accurate due to other factors playing into the
> runtime, performance difference between XFS and ext4 seems to be an
> order of magnitude. (Ballpark runtime XFS is 30 mins, while ext4
> handles the remove in ~3 mins).
>
> The XFS performance seems to be completly dominated by log buffer
> writes, which happen with both REQ_PREFLUSH and REQ_FUA set. It's
> pretty obvious why this kills performance on slow spinning rust.
>
> Now the thing I wonder about is why ext4 seems to get a away without
> those costly flags for its log writes. At least blktrace shows almost
> zero PREFLUSH or FUA requests. Is there some fundamental difference in
> how ext4 handles its logging to avoid the need for this ordering and
> forced access, or is it ext just living more dangerously with regard to
> reordered writes?
>
> Does XFS really require such a strong ordering on the log buffer
> writes? I don't understand enough of the XFS transaction code and
> wonder if it would be possible to do the strongly ordered writes only
> on transaction commit.
>
> Regards,
> Lucas

Your immediate question sounds like an artefact.  I think both XFS and 
ext4 flush the cache when writing to the log.  The difference I see is 
that xlog_sync() writes the log in one IO.  By contrast, 
jbd2_journal_commit_transaction() has several steps that submit IO. The 
last IO is a "commit descriptor", and that IO is strictly ordered 
(PREFLUSH+FUA).

Unless you have enabled `journal_async_commit` in ext4.  But I think you 
would know if you had.  I am not sure whether that feature is now 
considered mature, but it is not compatible with the default option 
`data=ordered`.  And this fact is still not in the documentation, so I 
think it is at least not used very widely :-). 
https://unix.stackexchange.com/questions/520379/

Maybe XFS is generating much more log IO.  Alternatively, something that 
you do not expect might be causing calls to xfs_log_force_lsn() / 
xfs_log_force().

In future, it would be helpful to include details such as the kernel 
version you tested :-).

Regards
Alan


Google pointed me to xfs_log.c.  There is only one place that submits 
IO: xlog_sync().  As you observe, this write uses PREFLUSH+FUA.  But I 
think this is the *only* time we write to the journal.

/*
* Flush out the in-core log (iclog) to the on-disk log in an asynchronous
* fashion. ... bp->b_io_length = BTOBB(count); bp->b_log_item = iclog; 
bp->b_flags &= ~XBF_FLUSH; bp->b_flags |= (XBF_ASYNC | XBF_SYNCIO | 
XBF_WRITE | XBF_FUA); /* * Flush the data device before flushing the log 
to make sure all meta * data written back from the AIL actually made it 
to disk before * stamping the new log tail LSN into the log buffer. For 
an external * log we need to issue the flush explicitly, and 
unfortunately * synchronously here; for an internal log we can simply 
use the block * layer state machine for preflushes. */ if 
(log->l_mp->m_logdev_targp != log->l_mp->m_ddev_targp) 
xfs_blkdev_issue_flush(log->l_mp->m_ddev_targp); else bp->b_flags |= 
XBF_FLUSH; ... error = xlog_bdstrat(bp);


Whereas I see at least three steps in 
jbd2_journal_commit_transaction().  Step 1,  write all the data to the 
journal without flushes:

	while (commit_transaction->t_buffers) {

		/* Find the next buffer to be journaled... */

                 ...

		/* If there's no more to do, or if the descriptor is full,
		   let the IO rip! */

		if (bufs == journal->j_wbufsize ||
		    commit_transaction->t_buffers == NULL ||
		    space_left < tag_bytes + 16 + csum_size) {

                         ...

			for (i = 0; i < bufs; i++) {

                                 ...

				bh->b_end_io = journal_end_buffer_io_sync;
				submit_bh(REQ_OP_WRITE, REQ_SYNC, bh);
			}

Step 2:

	err = journal_finish_inode_data_buffers(journal, commit_transaction);
	if (err) {
		printk(KERN_WARNING
			"JBD2: Detected IO errors while flushing file data "
		       "on %s\n", journal->j_devname);

Step 3, commit:

	if (!jbd2_has_feature_async_commit(journal)) {
		err = journal_submit_commit_record(journal, commit_transaction,
						&cbh, crc32_sum);
		if (err)
			__jbd2_journal_abort_hard(journal);
	}
	if (cbh)
		err = journal_wait_on_commit_record(journal, cbh);


static int journal_submit_commit_record(journal_t *journal,
					transaction_t *commit_transaction,
					struct buffer_head **cbh,
					__u32 crc32_sum)
{
...

	if (journal->j_flags & JBD2_BARRIER &&
	    !jbd2_has_feature_async_commit(journal))
		ret = submit_bh(REQ_OP_WRITE,
			REQ_SYNC | REQ_PREFLUSH | REQ_FUA, bh);

