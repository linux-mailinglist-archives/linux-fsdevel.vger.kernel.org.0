Return-Path: <linux-fsdevel+bounces-14558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D725287DB1A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Mar 2024 18:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EF86B21C93
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Mar 2024 17:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC2C1BF3A;
	Sat, 16 Mar 2024 17:32:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.lichtvoll.de (luna.lichtvoll.de [194.150.191.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2491BDCE;
	Sat, 16 Mar 2024 17:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.150.191.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710610326; cv=none; b=YsRNjnoSRVQUk42TELyv5cYlZtqwhBaz2zibeiIt+lEgeTURqxXvKXnzNWlxvpQXW6ddvR+vYT7h0mZq46dqoyOcoltsdJ6dXxsteRm9+ZOakeAubmrP+RQTqzQfABAAbVRuGPfLHBWAo3ny8KPw2z0TwWG6/vaN3ao6nACPNq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710610326; c=relaxed/simple;
	bh=YtFRgsbCyrPdSjoqm5wDEqRAKmSaXz1ojStkEmehoqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eXQ1huV5RxP7LFXVdrnkyfNtuACagNPrPtX74Y74hPDFObTkqOxK5tR87VVgmOHy9QQ7FyK58aueZlOY8ZJpcp6gsXx057Ij2UxXu2e0cpclHq2U3GaPTpWt1XvZsszTDMQQVfBp1lXDULSgafALlOxnSgvkX92/V9nGGq2XZ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de; spf=pass smtp.mailfrom=lichtvoll.de; arc=none smtp.client-ip=194.150.191.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id E76AC8C259D;
	Sat, 16 Mar 2024 18:31:58 +0100 (CET)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: bcachefs: do not run 6.7: upgrade to 6.8 immediately if you have a multi
 device fs
Date: Sat, 16 Mar 2024 18:31:58 +0100
Message-ID: <12401121.O9o76ZdvQC@lichtvoll.de>
In-Reply-To: <1962788.PYKUYFuaPT@lichtvoll.de>
References:
 <muwlfryvafsskt2l2hgv3szwzjfn7cswmmnoka6zlpz2bxj6lh@ugceww4kv3jr>
 <foqeflqjf7h2rz4ijmqvfawqzinni3asqtofs3kmdmupv4smtk@7j7mmfve6bti>
 <1962788.PYKUYFuaPT@lichtvoll.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Martin Steigerwald - 16.03.24, 17:49:52 CET:
> > > Unfortunately I need to do exactly that, as 6.8.1 breaks hibernation
>=20
> > > on ThinkPad T14 AMD Gen 1:
> [=E2=80=A6]
>=20
> > run this tree then:
> >=20
> > https://evilpiepirate.org/git/bcachefs.git/log/?h=3Dbcachefs-for-v6.7
>=20
> Wonderful. Thanks! Compiling this one instead. Shall I report something
> to you once I booted into it? I read you had difficulties getting those
> patches into stable.

It seems that the downgrade succeeded.

=46irst mount:

[   22.565053] bcachefs (dm-5): mounting version 1.4: (unknown version) opt=
s=3Dmetadata_checksum=3Dxxhash,data_checksum=3Dxxhash,compression=3Dlz4
[   22.565686] bcachefs (dm-5): recovering from clean shutdown, journal seq=
 116996
[   22.565717] bcachefs (dm-5): Version downgrade required:

[   22.590487] bcachefs (dm-5): alloc_read... done
[   22.597896] bcachefs (dm-5): stripes_read... done
[   22.597930] bcachefs (dm-5): snapshots_read... done
[   22.651106] bcachefs (dm-5): journal_replay... done
[   22.651667] bcachefs (dm-5): resume_logged_ops... done
[   22.651736] bcachefs (dm-5): going read-write

I wonder whether there was some text supposed to follow
"Version downgrade required:". The line feed was in the output.

Second mount:

[  113.059224] bcachefs (dm-5): mounting version 1.3: rebalance_work opts=
=3Dmetadata_checksum=3Dxxhash,data_checksum=3Dxxhash,compression=3Dlz4
[  113.059259] bcachefs (dm-5): recovering from clean shutdown, journal seq=
 117013
[  113.083911] bcachefs (dm-5): alloc_read... done
[  113.091268] bcachefs (dm-5): stripes_read... done
[  113.091281] bcachefs (dm-5): snapshots_read... done
[  113.142374] bcachefs (dm-5): journal_replay... done
[  113.142390] bcachefs (dm-5): resume_logged_ops... done
[  113.142406] bcachefs (dm-5): going read-write

Thanks,
=2D-=20
Martin



