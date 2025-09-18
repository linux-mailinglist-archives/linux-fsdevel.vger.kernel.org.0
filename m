Return-Path: <linux-fsdevel+bounces-62057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FF1B82788
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 03:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F9564A2AAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 01:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F71201266;
	Thu, 18 Sep 2025 01:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="2Oq2G53j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375FB1DF748
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 01:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758157640; cv=none; b=b+9h17b1FsE5vck43dxYPOPum7Wx4Gj0MYtU4IGJGN7ZXFKcwB7iObEIrLEE5aFRuxm/72c/Xa7dwVP+nXXmqbRGi5SmdMvIToKMFKsf7HuZyKtSK5wN2jfV6iNoY2nQF8qa4oOqxbDHH7DVg9jJoO32kL9suWZToEUOzs97WBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758157640; c=relaxed/simple;
	bh=Jyh/T1VQujpBIetRlEwQ9WKQ0pDM9Occu70Vj9kJ3PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emf6aNKVy4ZBi3kwbwEUb3yeTytTAq/7GgM8bpPTS7l81L0niMaVU19+Gtlpcj0ilb7uHB+SYmCJu8HANSSfKL1xev8XsyOyiR+IGWz66/vN/5+6Xb11jKqkoAPUBub2hMKYMwbZry5HZZjF1kcILYj+K+x+mRRV7BHRccxM7a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=2Oq2G53j; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7742adc1f25so348868b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 18:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1758157638; x=1758762438; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p3n6Uf5fmho3K1YmaoGj4njt8YRbuIHtLi1zAXG6OwM=;
        b=2Oq2G53jiImhW9tX7gMzXIqb746T/KHiolWjo9MhwMcmkOJWUdUilafdNEy5FEC2Lv
         f144ESPYsmq+enFn/UH5FgTuGu7rKoPe1h6aSkIZUCSFMI/VND1Vbfl8fD/EtkmHDEVe
         vIDRcKrjsAQGgp3bkDZTq+IPaJYukxNbTn/DNJGSzARiZOuEHxFxQMHMeBgI14YPmiw3
         qDEF2TuHKMN6Hg96bnmfulLcNDGQfX+7EsaRSzk7PdMQj4g2YMJYM3ZY8TkCOxs3U7MV
         +jMWJusmd/DA6NjdU3oAQYRD1tcb1Y23QVEbCMbDKNAE2aq6yDFdkG7y2/7AI+pWdEr+
         z2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758157638; x=1758762438;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p3n6Uf5fmho3K1YmaoGj4njt8YRbuIHtLi1zAXG6OwM=;
        b=d+9SZ+stQKJP4axatomVnRNhT+32y2gfC/RVIAzAHdW52UX0hRyX/zGN7Xp+yMqxfy
         NDLSrd+LLmeAE34qPXJ9AQMRX67IN8S+I5IPScztun3E/3EMU53TOq9xDTUXQqtmq7+L
         3qYfeyttucdoVNvVssSDEhdkjaH/v+7Th0CspV5HzAFmLWRIdJ23ic6MMArEQwcvI/TO
         nHfvyijG0lg/1ziZl7DDtnwKTDDYuS1XJ4qUg57j1butZOXdgdeMF41G0lFaZsE5bEXh
         GYq6InjhU523kNCu7C32cnZ2n/jG1eYLF73x2s8mk24xk+HhCNvaEM4HA7JGl4ZtxVO6
         vFlg==
X-Forwarded-Encrypted: i=1; AJvYcCXnjTcdP69Z7/duJiXjovYrRX5qaLFzWMeC6y71VzcNM8O/IMK2qoCVIiwxukpddRyH/LTLGX+R57XVa5l+@vger.kernel.org
X-Gm-Message-State: AOJu0YzM4Wo3FqtanWvBqtscTwwrD8Mii/LCA1XH/LuqhVEi3MFC1Cu5
	gEmWNMe/RhF7YlFaVVU7eFsLu3wd3BKCFliQIzbDMXOQeC71DnLIUy7whZaoO7eY3jA=
X-Gm-Gg: ASbGncucidF1p3DC/uQVJ1JNZebbUCqWc5CAvcPEKDP5MhiB1L/ZOqtUDuB6JRD0+8U
	1gQ5KZqSlkvu/OEt5LWzxr2CPOEvJaJEXerIbZsNVIeHOL3tvZnVTh3epK8ZTHn1F9lpv7rAH8z
	H3ClA/46IDv5GN59oQm7DXh8dN9olD2ySHBUzo5Ul0LAjaIVQl5hGKqU2OFp9MSq5XuKB1Yw0Mc
	CEGPawww480XA3kTmatTphTwg2GYm/3pSbpoWoxsKPa5axiW91RTuGtdA4auKnwR5N8TXdKxHNq
	h5qicabloPR0KkRsgNC6yRIDYO66StXK9yKSNeQ6DwBDYZXBJ7DhqdLkLoDcBa1XyYJX5Jd3wqD
	vy4tC/krY8om0r0qc4qnJ9234LcvdgivZFn/8AJ0tkxBjbzP6Q0Y0ak93vaj8ioUqFWy5CMh9bR
	T7K21P9A==
X-Google-Smtp-Source: AGHT+IGuCJoEhQgAv+Omg49c7c/B2Tcr3E0BGIChrElfWl6Pxd6ZK4K1F7fPmkeQRRASiKleSW/EoQ==
X-Received: by 2002:a05:6a00:2350:b0:776:1834:c8c7 with SMTP id d2e1a72fcca58-77bf9664586mr4517640b3a.26.1758157638566;
        Wed, 17 Sep 2025 18:07:18 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfec40185sm605187b3a.77.2025.09.17.18.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:07:17 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uz37D-00000003LBO-2MNV;
	Thu, 18 Sep 2025 11:07:15 +1000
Date: Thu, 18 Sep 2025 11:07:15 +1000
From: Dave Chinner <david@fromorbit.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Max Kellermann <max.kellermann@ionos.com>, slava.dubeyko@ibm.com,
	xiubli@redhat.com, idryomov@gmail.com, amarkuze@redhat.com,
	ceph-devel@vger.kernel.org, netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ceph: fix deadlock bugs by making iput() calls
 asynchronous
Message-ID: <aMtbQzb-aFPtjttc@dread.disaster.area>
References: <20250917124404.2207918-1-max.kellermann@ionos.com>
 <aMs7WYubsgGrcSXB@dread.disaster.area>
 <CAGudoHHb38eeqPdwjBpkweEwsa6_DTvdrXr2jYmcJ7h2EpMyQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHHb38eeqPdwjBpkweEwsa6_DTvdrXr2jYmcJ7h2EpMyQg@mail.gmail.com>

On Thu, Sep 18, 2025 at 01:08:29AM +0200, Mateusz Guzik wrote:
> On Thu, Sep 18, 2025 at 12:51 AM Dave Chinner <david@fromorbit.com> wrote:
> > - wait for Josef to finish his inode refcount rework patchset that
> >   gets rid of this whole "writeback doesn't hold an inode reference"
> >   problem that is the root cause of this the deadlock.
> >
> > All that adding a whacky async iput work around does right now is
> > make it harder for Josef to land the patchset that makes this
> > problem go away entirely....
> >
> 
> Per Max this is a problem present on older kernels as well, something
> of this sort is needed to cover it regardless of what happens in
> mainline.
> 
> As for mainline, I don't believe Josef's patchset addresses the problem.
> 
> The newly added refcount now taken by writeback et al only gates the
> inode getting freed, it does not gate almost any of iput/evict
> processing. As in with the patchset writeback does not hold a real
> reference.

Hmmmm. That patchset holds a real active reference when it is on the
LRU list.

I thought the new pinned inode list also did the same, but you are
right in that it only holds an object reference.  i.e. whilst the
inode is pinned, iput_final won't move such inodes to the LRU and so
they don't get a new active reference whilst they are waiting for
writeback/page cache reclaim.

That in itself is probably OK, but it means that writeback really
needs to take an active reference to the inode itself while it is
flushing (i.e. whilst it has I_SYNC is set). This prevents the fs
writeback code from dropping the last active reference and trying to
evict the inode whilst writeback is active on the inode...

Indeed, comments in the patchset imply writeback takes an active
reference and so on completion will put inodes back on the correct
list, but that does not appear to be the behaviour that has been
implemented:

	"When we call inode_add_lru(), if the inode falls into one of these
	categories, we will add it to the cached inode list and hold an
	i_obj_count reference.  If the inode does not fall into one of these
	categories it will be moved to the normal LRU, which is already holds an
	i_obj_count reference.

	The dirty case we will delete it from the LRU if it is on one, and then
	the iput after the writeout will make sure it's placed onto the correct
	list at that point."

It's the "iput after the writeout" that implies writeback should be
holding an active reference, as is done with the LRU a couple of
patches later in the series.

> So ceph can still iput from writeback and find itself waiting in
> inode_wait_for_writeback, unless the filesystem can be converted to
> use the weaker refcounts and iobj_put instead (but that's not
> something I would be betting on).

See above; I think the ref counting needs to be the other way
around: writeback needs to take an active ref to prevent eviction
from a nested iput() call from the filesystem...


-- 
Dave Chinner
david@fromorbit.com

