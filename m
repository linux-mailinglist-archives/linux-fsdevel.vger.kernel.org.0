Return-Path: <linux-fsdevel+bounces-76242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GS6jLgPJgmkJbQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 05:20:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F8DE1862
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 05:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 824BC30AB59E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 04:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9939F34C9AD;
	Wed,  4 Feb 2026 04:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="KJUJUXHk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022A4233704;
	Wed,  4 Feb 2026 04:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770178807; cv=pass; b=RceVV9GecQkD+SiCJeoNbzf5WGDPvV/qHVPs49br0dLWWrdISGNtluqWgHS28gmm05V46CuMcHXtNV04KlteXPS7W+s0M5pnVwMRjgFgq1yS1OeUEJuV32inhEb4+YP/LEWaOniFxykweR0IMbpuQg1QaspQRe69uAC2Oss43Ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770178807; c=relaxed/simple;
	bh=6dAtgl9u81VYcGc6fcRDkG0iBV934NWOit6GZ1ZbHso=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EP0zXCF0a1AIJVBcL0W6G6tuvlUBpn4JHbSDSdyX40L+dYKoFBCpFiigHuMBCR0+Dm0k4JkLgYjWQdg4Hdn7rc3ckc9oquZvyBIutX9Z9tSrndv6WDPztRfg/jT701DKRuHusO+wh6cygxkiIGUDWAvqNuK5aTQWs5kUz/gBZZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=KJUJUXHk; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1770178770; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZOS4PTOOAbjF5vdly5tyTtEX6eKWlgkpS1cYtJVpVt89uZ1R8iv1acCwG5rDhS6uYI605HYbLH5MyWPbDTsXBVVAlcmLBQ8SDMpMFGChwDema42QRtptnxxmzvNr7+GT18XOv1oCwOsl7JYgHapDxQpaHseF7qI/tgvEyaiewTU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770178770; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6dAtgl9u81VYcGc6fcRDkG0iBV934NWOit6GZ1ZbHso=; 
	b=cLVytt8MBzP98WSojsUvZznMzzONdi7m7Jka6JRo9T8rx518X2ePzooXMFVztrPu54W8JsXNKLhEpr6/tjVve7RIIPswqXY007TS2eCGqiXBJ3Zhyz4b/0Y5S4qXiynMJTwziWijwb+x7qnBZEE9jHK3bNePC5AwP2n00lVwV2U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770178770;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=6dAtgl9u81VYcGc6fcRDkG0iBV934NWOit6GZ1ZbHso=;
	b=KJUJUXHkC7j3Gg0KvSBPC/EsFB1vCGkQYzZbE+rDSlFozQaM9GSWAjZME5tyC8sO
	NjL8onu8XIqKCD3MATOTovt8VGaxiC1gK0aFlGxlV6c4g+vS/EniEPLcVz1jse+5fy8
	byXKUsOrIbOrde4TcoNwh5e6GoZXQeF0jTc9ENc4=
Received: by mx.zohomail.com with SMTPS id 1770178766709494.13939849890244;
	Tue, 3 Feb 2026 20:19:26 -0800 (PST)
Message-ID: <4375f20e2b0d3507a0209f7129e00d360d3eb32c.camel@mpiricsoftware.com>
Subject: Re: [PATCH v2] hfsplus: fix s_fs_info leak on mount setup failure
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, "viro@zeniv.linux.org.uk"
	 <viro@zeniv.linux.org.uk>
Cc: "jack@suse.cz" <jack@suse.cz>, "frank.li@vivo.com" <frank.li@vivo.com>, 
	"brauner@kernel.org"
	 <brauner@kernel.org>, "linux-fsdevel@vger.kernel.org"
	 <linux-fsdevel@vger.kernel.org>, "slava@dubeyko.com" <slava@dubeyko.com>, 
	"linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "glaubitz@physik.fu-berlin.de"
	 <glaubitz@physik.fu-berlin.de>, "janak@mpiricsoftware.com"
	 <janak@mpiricsoftware.com>, 
	"syzbot+99f6ed51479b86ac4c41@syzkaller.appspotmail.com"
	 <syzbot+99f6ed51479b86ac4c41@syzkaller.appspotmail.com>, 
	shardulsb08@gmail.com
Date: Wed, 04 Feb 2026 09:49:20 +0530
In-Reply-To: <b9374ab2503627e0dd6f62a29ab5dcde9fc0354f.camel@ibm.com>
References: <20260201131229.4009115-1-shardul.b@mpiricsoftware.com>
	 <cace4df975e1ae6e31af0103efcbca9cdb8b8350.camel@ibm.com>
	 <20260203043806.GF3183987@ZenIV>
	 <b9374ab2503627e0dd6f62a29ab5dcde9fc0354f.camel@ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mpiricsoftware.com:s=mpiric];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76242-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vivo.com,kernel.org,vger.kernel.org,dubeyko.com,physik.fu-berlin.de,mpiricsoftware.com,syzkaller.appspotmail.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mpiricsoftware.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shardul.b@mpiricsoftware.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_DNSFAIL(0.00)[mpiricsoftware.com : query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,99f6ed51479b86ac4c41];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mpiricsoftware.com:mid,mpiricsoftware.com:dkim]
X-Rspamd-Queue-Id: 59F8DE1862
X-Rspamd-Action: no action

On Tue, 2026-02-03 at 23:35 +0000, Viacheslav Dubeyko wrote:
> On Tue, 2026-02-03 at 04:38 +0000, Al Viro wrote:
> > On Mon, Feb 02, 2026 at 05:53:57PM +0000, Viacheslav Dubeyko wrote:
> > > > =C2=A0out_unload_nls:
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unload_nls(sbi->nls);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^^^^^^^^^^^^^^^^^^^^
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unload_nls(nls);
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(sbi);
> >=20
> > > The patch [1] fixes the issue and it in HFS/HFS+ tree already.
> >=20
> > AFAICS, [1] lacks this removal of unload_nls() on failure exit.
> > IOW, the variant in your tree does unload_nls(sbi->nls) twice...
>=20
> Yeah, I think you are right here.
>=20
> Shardul, you already spend the time on this solution. Could you
> please modify
> your patch to fix the issue finally by correcting the patch that
> already in
> HFS/HFS+ tree?
>=20
> Thanks a lot,
> Slava.

Sure, will send a v2 with just the unload_nls removed.

Thanks,
Shardul

