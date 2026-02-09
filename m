Return-Path: <linux-fsdevel+bounces-76692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8P//MmOuiWndAgUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 10:52:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7EF10DCD7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 10:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BCDD3034661
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 09:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D0A33B6D9;
	Mon,  9 Feb 2026 09:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="dLqrVPUl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12442C3259
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 09:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770630428; cv=pass; b=laLTPh+6D9VAKn5Sr4xbnH8iRrm7OgKWDCai8jBmaSCuTWGbn/5/GH0i9ka7pqIFlvqhZnpTjJMDEdTHELHyeZDKp8EBH7NEhr5sh2CU7WK2eWFF/Mb9XHmBNiAoxgCdmjpjEbMBJQCrDdjnInzsICnW/4SufBGo2S1ezghXQNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770630428; c=relaxed/simple;
	bh=kslYdqR/Eeds+pnHFX4dOlw3YR4a+aL+uxqVvQbwvrY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tPugniNqC7dF0orx3RL7jCCg9n9Rp7o9GHjvwnlB0s+C+h8y8826cYHkvsBVTIURKyNAQPH95SagAfViat3HjQWME4zT6ou7XMZOE1db8eWGwXEUhl+ZNU4q+aeVNAIC5AgyzA2NsVLRXEG9Vv5foYkj0605Ahz32c8xsgentGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=dLqrVPUl; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-895341058b1so40825086d6.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Feb 2026 01:47:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770630426; cv=none;
        d=google.com; s=arc-20240605;
        b=CvBSlf1x6xJU0bKmKfhEYflg8H0f5ANYTWZdV9Bt8uU6/hGIgUxRVc3jSmnRdJhJbg
         +/tRmcjw5X7j+HkXhfnUGw1+F44USotOn077K+98rSelDn22Nc5P/r47+kSbmWztJXn6
         vlxQwyPu9LNjczRNBFYIegv2x0Bebiai90K28V28lsyEC+htucCMojBgOjMlAsfk003U
         J0+/AiVFdqtoNoJDGVl/odttKHui921zycbpY9TS6y7otGo7FgXEuNS9Qji0JMQxs/th
         2PJUzKFUj9hPVs0Fmx17BC56/j+kMBXdLsIGZuRKkXUi69EVYUTuScJrLSkqwemAtx5P
         M1ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=MhbUYQBRSHqJLFTCcNvNjXM5Nu9GEAvwhrEdsxUNUHw=;
        fh=CoSNibkjlQs+KE6N/HkiSSMH39NBnEecuZFO0TS6L5A=;
        b=FsuSE4lKHQ7Am+Aw8QtnrZFhpbpqgwgYJy8bMojgJYR/gZ54J+55y1XqO3NlHWMuvx
         d11wtxzSUojVwN2sziaUQBM7at4BbNMKbOGOPKFWut3bwLOEyCb7IjwtWWUV+TH8oqR/
         ntLxlSYS1Ii+0QzQVIBfTRiCm9SepWAohVl13sBen5jmR9Dq1UY+agkIxGqLR8aQRRKQ
         vrDHsbS7eHI6TspnoJ7cQM4AelIVhqJiTY/QKmgF0p53wKvzt/A2y20x6J7AQd6IZXGx
         95nnj2WprdIE4zS7czs2UCF0ae2ZtQ2uMSGlafY3NpWysnEGHCiC/X+Rlz7nkj+oM2DP
         VRuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1770630426; x=1771235226; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MhbUYQBRSHqJLFTCcNvNjXM5Nu9GEAvwhrEdsxUNUHw=;
        b=dLqrVPUlgWH8s70iuf87BTLXR0c3co+h9xD4nuv93T7Xk3UtPACbeTo+5mu2YD/tf2
         MLoysDWLD5MwAAtrg5WyxovXcu+Wm6kbGFNeoWszMaMdS9LbwB31VzyazUJOVZKQsUIy
         YVzsnY7Uc8RS4cevalkd7RvfQ35FV0mFGPSQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770630426; x=1771235226;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MhbUYQBRSHqJLFTCcNvNjXM5Nu9GEAvwhrEdsxUNUHw=;
        b=aiMem/xQSHTzOrhQeXv3RTgDaMKYa9uk9tk49Ier0LqbH60eKkMdocMBiedK6+OaZA
         EO4MWI26m0cT1IK0YtSEGUAooljZls4QsP8gCymvhb/cKVjhFhMXDZpLW2wKw/ZcdVdx
         TjgkbrFiwPNfRtbFzYnkqKf+/0X1PLf7f1Dbi2a6QM3tVlWjVZaE/Cf4YS+JUVYhVof6
         MsdUYY9GcrsM2mqjmSMHdZGUUG1GZeFhK/3WRgBoQ1P6gftZm/p8tny+UW/st0IF3uYj
         bWX3QWh4Hmv6uwpCDRcJkSViJSM9pSJpv5f5OEZppIs6JmyAf1T6qoluxUHbLZ2Wyzkx
         rNeA==
X-Forwarded-Encrypted: i=1; AJvYcCUZ2uvmoBI1VgPVx7JXjrVewBbkZzD5HmPaRatt4KHjYovkgu8a79GRKaaIlj+KVlRxvP5N2rDTVHU3ObC+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0GIz+Bp+kOnCPoyLYIyHoLjzvACv9u9m964HSO3wRAW7T2Uq5
	qhCFO+cZCJMcv75+a2xHcJMOJvw5V5O0H5YVueG7FSI7K++HbaO/odSmBkptTqPoDMJisDP8yVl
	Fn/0P6Fp8gvI6BRsc4QgST2ECSRpmqPmospYDaILOxT+49pVXIChUGLg=
X-Gm-Gg: AZuq6aI1m1Il1+sUKk7d/EYpoZVqDv8kYBKgxlw1QC/4ka46hmvVUqMrwYOtDRYMDrq
	KMXkZzzqEqWk8QhSK5u/WdePSjJPSKBzpJmCATgxYQ3Eqv/zST5g3/kysQU9cAU292vGgxAuIuk
	Cs0RhKBuepC0BAOthyAEHIxWd2GEOqzGUDd7/eKhg+SPv4skc9dVIWcXX0Xz3lUP9T9jzDGojIO
	StA/CTr4QL9oa62B3tJTG0A1MUrYCUEclB8krGprs7ffdl9z/bfOo88RnrDJjsZOhjktA==
X-Received: by 2002:a05:6214:1313:b0:894:2cb3:d11f with SMTP id
 6a1803df08f44-8953c7e4bf2mr170464966d6.18.1770630426393; Mon, 09 Feb 2026
 01:47:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 9 Feb 2026 10:46:54 +0100
X-Gm-Features: AZwV_Qjy3xnJNEFhzfsyr6-tHP122kxtgH4LciILKjduIFPXSjrwE2RS0X3s71w
Message-ID: <CAJfpegu0PrfCemFdimcvDfw6BZ2R5=kaZ=Zrt6U5T37W=mfEAw@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] xattr caching
To: lsf-pc <lsf-pc@lists.linux-foundation.org>, linux-fsdevel@vger.kernel.org
Cc: Linux NFS list <linux-nfs@vger.kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76692-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[szeredi.hu:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3D7EF10DCD7
X-Rspamd-Action: no action

I'm looking at implementing xattr caching for fuse and wondering how to do this.

Why is there no common infrastructure?

Should we create one?

What currently exists:

- mb_cache for ext2/4.  This seems to be used for deduplicating data,
so it's no good for fuse, afaics.

- simple_xattr for tmpfs/kernfs. This looks good, except it doesn't
have a shrinker, for obvious reasons.

- nfs4_xattr_cache for nfs. I don't really understand the design
choice of separate cache tables for each inode, which seems wasteful
for the common case of just a couple of xattrs per inode(*).

Without having looked deeply at each implementation, I'd think that
combining the features of all of the above into a common utility would
make sense.

Large, multi page xattrs (which I haven't seen in the wild, but I'm
sure they are out there) should be cached similarly to file data.
Small values could be stored "inline".

Deduplication of keys, values and lists is probably also useful.

Shrinking would not be used for tmpfs and kin, just like the other caches.

Any other considerations?

Thanks,
Miklos

(*) Either a global hash table or per-inode rb-trees would be saner choices.

