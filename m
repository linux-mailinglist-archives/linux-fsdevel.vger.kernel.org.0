Return-Path: <linux-fsdevel+bounces-77375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAK+HqeZlGkoFwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 17:39:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1867F14E504
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 17:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 18A933012521
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 16:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02172361DAE;
	Tue, 17 Feb 2026 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="AotzhMwj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2951335BC0
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 16:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771346338; cv=pass; b=spseO5UyCnGl6hCZaIPZx+J16nDJQ0T3xltMvo5DQPMy1WLMqIfaKUBbqgJ/BDvzyrNvAs9TJdrNAJgU8ESMxMebICOV/4lFQEc97daceJfEzj8rgD+VZB1tIu+P4DJnXNKlwZ2qHVhd8ftHrFlp7j/EMWSjpazDhCf68NwbBjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771346338; c=relaxed/simple;
	bh=pueFV7HOmTlAMLWa6283FfSZgreS6HqjRbkpeZmf0Yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TAjxheZKv0wxeO+tk6vcvzFMRZnwuaGNyBM3nRS27NLkshd7AIh//L5vGzNmgvZloOqHP5YuSwNoO9iqtCmXr6PbjMdo7qyW8pC8YO9h8FnimDg1ZF7Q8/mlGLYKxqjbZFS5XRt/rGuriOZurLtSeaGku5VcvLSSYswWNquu+Ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=AotzhMwj; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-506a747448dso34537051cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 08:38:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771346335; cv=none;
        d=google.com; s=arc-20240605;
        b=UrwoYKh6myws5OiBestLJyiSCopHvqju7WPglh5n+6eu26m4vLnH7dmusbCjzUhMrn
         mFv06YrFVyJKpsicrwBfQ9LLRzTfIqflapB4mHA20y2Y/LFNs+0IgO1CBC5GCqDCegfM
         JSZRwqnT02xU+DLK5dZn7rlhklk+8GFXUbXs06xYoRNreaZ9UVPPFZdpGBw1qxnGvP2N
         Lv6Y7NGQCjHdvBNMXXYoc0UaJuRj7hthYd0ZmKx+mgjdO42GY1J17IZG9EBqL8QYbAVa
         CXaD2OqPI8CACZqk2F1MfurjpCmOwMiJ6i9kb61CSLpJL16EdcDwOrilQ42DSui5qhnA
         hOpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qIgSLJPLCnCn47nlm5eRqhg9b97oTgZRqUoe0QTgjvA=;
        fh=n6n8trHKuZXhaWTfCZuuw77InGw7tC0e7c4fetpr6q0=;
        b=QAgcv2Weu85GaXNBciv8m12e6GpgFcGYSFF5fiCsTDpTD9kV19cT/vlXk8IF8OUN71
         /gyuCNSX80v2t3w/8mNcFqM0nJYKS+AKqM3cZ3fI0xGdjehorycFuhLYqlnOtRwpJpKp
         TJp8Hx5GyBn+vR9blYdqE7YSchixq/ml9QOWeJXb2+fBeVRejQmBZpLsxKojHkXQXJFl
         TlS5aM1ex4AQv8xhuRVMr2x9zZFsYXI9/HbHloolYrmhlauQGkpyJYEvRUnyucM+pSmO
         mmdTHEpwBIMpm8S4atnQdarYE66fhaWAEtZhkpejJ94IokYtVe+RKzRac3eCd0UkuZk5
         4vlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1771346334; x=1771951134; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qIgSLJPLCnCn47nlm5eRqhg9b97oTgZRqUoe0QTgjvA=;
        b=AotzhMwjLZ5wEn8/+2EOglDgHflXoLSBKnxsrZ/XIhD4Yt015HXaatf81objC2ljBQ
         Bs1wBZOovgruDxCCkVIaje3U+43Ww7lkXGJm1At0cnkFFPBbtGc5Ex+aqQeJcsNSCmsT
         oCR96BfbdF17Yl2AMcYXUzgXStQRcEkyBmBmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771346334; x=1771951134;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIgSLJPLCnCn47nlm5eRqhg9b97oTgZRqUoe0QTgjvA=;
        b=Ce+IY9o1Whu+PkDGfFwkEIcLiFOwI2SgRjTAIYpRs3spoXR0rVurt0VgWjjCdE3gAm
         VEXDIytaN09EBBpPK0TN9PXhMFDd3lWJORs/1VXkb2sCTvLWCgMX3mlKVv9DHZvlcn2w
         P+BEWLDV4EVLrmZvLbdERSQFRTZGp27POq870n4bwpXcUDkd7gMwUvw4lI6mfpKW3Y23
         ZLif6WdNiDGRCt+eBzmp+vFKjI2Bo+Fi5l332N31wnGEAB0J1zYTHXFakFiGrs5A2fBj
         wy4cZq/joyASKyq2aYtwlXDcTM3RCPBwkuLgk2RRZfswQNqGwwbcbHsLeHrB760/yq9M
         X20w==
X-Gm-Message-State: AOJu0YyT6zx14OAyip1ZU7lbcrapc2Ong0c7ABfGizYxhbt9QG/G3dFs
	4sGEWpefFMpiYbeYOpbCD663wayezI2IMqmSJIttSIzJXpMjkvnUM2SFp+b3bhrK5NNYLKc3/gx
	BLrxBn3OBn10GFAPDV5yJn/nhzeAq8Glf4bb31IhvCtDAJJAU8+R2
X-Gm-Gg: AZuq6aK4RpRJ+fRAm+t+KkwGJT5FZWbP0STFJIoL83oDy0UOJh5WKRa/LoN2mMb6Jra
	Sd5DIGkj6mXlty9SGw044/1HgFlCKFTTWY3R3z1uy9OXBsWfv3K3zM6NteHsO9oyQwjO5//3D5a
	4Y77xMMnZjl6DvDXWCFn1tW9iyRnzmih8/BVDlwjJPhTQIUGwHHp+byArspgIRmlqAItforF85/
	kYjN8dCSO3fxpQSA8A9Tk6tYU3oY2k2cm8xeDQ11Y5pIwh6aObZKxpnoMjLjLEgqEs7kKdmt4Jd
	HL+yMI4=
X-Received: by 2002:ac8:5a8a:0:b0:4f0:2afc:3b80 with SMTP id
 d75a77b69052e-506b4012c27mr164107911cf.56.1771346334529; Tue, 17 Feb 2026
 08:38:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260118232411.536710-1-slp@redhat.com>
In-Reply-To: <20260118232411.536710-1-slp@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 17 Feb 2026 17:38:43 +0100
X-Gm-Features: AaiRm53G7WAljHceOoQSUTIXzMhIcBywyAm51p1qCztu60cbOvA3mnF1eYfkKGQ
Message-ID: <CAJfpegusbxUN=EydA74Kp-GATYLziFUMmC9aTr80Q5B1AEd4AQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: mark DAX inode releases as blocking
To: Sergio Lopez <slp@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77375-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[szeredi.hu:+]
X-Rspamd-Queue-Id: 1867F14E504
X-Rspamd-Action: no action

On Mon, 26 Jan 2026 at 17:29, Sergio Lopez <slp@redhat.com> wrote:
>
> Commit 26e5c67deb2e ("fuse: fix livelock in synchronous file put from
> fuseblk workers") made fputs on closing files always asynchronous.
>
> As cleaning up DAX inodes may require issuing a number of synchronous
> request for releasing the mappings, completing the release request from
> the worker thread may lead to it hanging like this:
>
> [   21.386751] Workqueue: events virtio_fs_requests_done_work
> [   21.386769] Call trace:
> [   21.386770]  __switch_to+0xe4/0x140
> [   21.386780]  __schedule+0x294/0x72c
> [   21.386787]  schedule+0x24/0x90
> [   21.386794]  request_wait_answer+0x184/0x298
> [   21.386799]  __fuse_simple_request+0x1f4/0x320
> [   21.386805]  fuse_send_removemapping+0x80/0xa0
> [   21.386810]  dmap_removemapping_list+0xac/0xfc
> [   21.386814]  inode_reclaim_dmap_range.constprop.0+0xd0/0x204
> [   21.386820]  fuse_dax_inode_cleanup+0x28/0x5c
> [   21.386825]  fuse_evict_inode+0x120/0x190
> [   21.386834]  evict+0x188/0x320
> [   21.386847]  iput_final+0xb0/0x20c
> [   21.386854]  iput+0xa0/0xbc
> [   21.386862]  fuse_release_end+0x18/0x2c
> [   21.386868]  fuse_request_end+0x9c/0x2c0
> [   21.386872]  virtio_fs_request_complete+0x150/0x384
> [   21.386879]  virtio_fs_requests_done_work+0x18c/0x37c
> [   21.386885]  process_one_work+0x15c/0x2e8
> [   21.386891]  worker_thread+0x278/0x480
> [   21.386898]  kthread+0xd0/0xdc
> [   21.386902]  ret_from_fork+0x10/0x20
>
> Here, the virtio-fs worker_thread is waiting on request_wait_answer()
> for a reply from the virtio-fs server that is already in the virtqueue
> but will never be processed since it's that same worker thread the one
> in charge of consuming the elements from the virtqueue.
>
> To address this issue, when relesing a DAX inode mark the operation as
> potentially blocking. Doing this will ensure these release requests are
> processed on a different worker thread.
>
> Signed-off-by: Sergio Lopez <slp@redhat.com>

Applied, thanks.

Miklos

