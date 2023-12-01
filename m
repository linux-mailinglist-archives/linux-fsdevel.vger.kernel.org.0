Return-Path: <linux-fsdevel+bounces-4554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B95C800862
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 11:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B965E281445
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 10:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E960210F5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 10:37:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59877B2
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 01:56:37 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D2F481FD68;
	Fri,  1 Dec 2023 09:56:35 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C925013928;
	Fri,  1 Dec 2023 09:56:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id magWMdOtaWWgbgAAn2gu4w
	(envelope-from <jack@suse.cz>); Fri, 01 Dec 2023 09:56:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 55F54A07DB; Fri,  1 Dec 2023 10:56:35 +0100 (CET)
Date: Fri, 1 Dec 2023 10:56:35 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Support fanotify FAN_REPORT_FID on all filesystems
Message-ID: <20231201095635.e2ydmmdd22lntmrf@quack3>
References: <20231130165619.3386452-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130165619.3386452-1-amir73il@gmail.com>
X-Spamd-Bar: +++++++++++
X-Spam-Score: 11.69
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz;
	dmarc=none
X-Rspamd-Queue-Id: D2F481FD68
X-Spamd-Result: default: False [11.69 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_NOT_FQDN(0.50)[];
	 DMARC_NA(1.20)[suse.cz];
	 TO_DN_SOME(0.00)[];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[25.54%]

Hi!

On Thu 30-11-23 18:56:17, Amir Goldstein wrote:
> Jan,
> 
> In the vfs fanotify update for v6.7-rc1 [1], we considerably increased
> the amount of filesystems that can setup inode marks with FAN_REPORT_FID:
> - NFS export is no longer required for setting up inode marks
> - All the simple fs gained a non-zero fsid
> 
> This leaves the following in-tree filesystems where inode marks with
> FAN_REPORT_FID cannot be set:
> - nfs, fuse, afs, coda (zero fsid)
> - btrfs non-root subvol (fsid not a unique identifier of sb)
> 
> This patch set takes care of these remaining cases, by allowing inode
> marks, as long as all inode marks in the group are contained to the same
> filesystem and same fsid (i.e. subvol).
> 
> I've written some basic sanity tests [2] and a man-page update draft [3].
> The LTP tests excersize the new code by running tests that did not run
> before on ntfs-3g fuse filesystem and skipping the test cases with mount
> and sb marks.
> 
> I've also tested fsnotifywait --recursive on fuse and on btrfs subvol.
> It works as expected - if tree travesal crosses filesystem or subvol
> boundary, setting the subdir mark fails with -EXDEV.

Now all the patches have arrived. Queued into my tree.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

