Return-Path: <linux-fsdevel+bounces-59174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 582A2B35750
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 10:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABC93166AB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 08:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97EF2FE598;
	Tue, 26 Aug 2025 08:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="KlkWp9qh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E312FDC5A;
	Tue, 26 Aug 2025 08:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756197476; cv=pass; b=B9HAj2cb37Zec/wjUm23iaW38tmD+GlTbFGs5X0YyMdSesMwfUzff2wz9Pg1bChlTIVCHOVnxDQcivDMuxgzRbq2oSaTLQt4Ebjgv5eSii1tY7KhL10+d5D2DThC6XBGn9qp1Hcab46NMrrM467GzHk1qEvESNlJXUz1Z46ka7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756197476; c=relaxed/simple;
	bh=mZQ8sGkjXp4mYnrpUu44u381eroY+sRh5qCfYv9fwC0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=H3GpuJ0A2ALML904+Pt5VETohhyb5MGm8SHpx1kk6Payd89gYvXDrAwR780qEkOq+0zEuWz8sxGh4odUC0sUYuzGQU7jpXN1H/qxZooAqoliPv/6uqgvPdEZcsTTGx5QsqapcC2zUQxngsUNcXpxHy1+XlMfqSjGHegUoFfvZvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=KlkWp9qh; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1756197439; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FEbVp9fmw/wycJULPWRyDi+bIuNEXVGRXOJJ15dJBniKMAMkesYjutSAD4RjJQeiEj4p0/pfJtCLrh/1TyDf4WOffumZnkDa1r90liop66DsJNi/CDljasstH6stFoiL8FUtMdrn0Bhy6td/lIL5O/+Zh+IY5J9eKQa4GtXDq74=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756197439; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iH/2h7/gVRrEaCAr2vPepO3IuIUAeo1n9ApLNQ92r0w=; 
	b=dTeE+6ljL0QICfmNMIbMcLwAcMvMBUbKYyVaSxw7nkOzkEDKFwii5YszuBZXfgrgM2Rr26TKbeN8b934+tGlgNTEl3G7v9ZRB/auHalt6yR69jtEXQ/1E1g6EiFuH8mBjBh+/Zm6NJcjvdCe/t6CsiNW7lbMwxiwHA4Xo4qAmK4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756197439;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=iH/2h7/gVRrEaCAr2vPepO3IuIUAeo1n9ApLNQ92r0w=;
	b=KlkWp9qhqKSvcii4dlk8JOybJvoH01AScuhxJiiEH60n6J6Yx+aYZmLndLUk4R59
	2T/1QORNvAUFPkjWLXsBD+N1/gZq7JkBcNpdqm0FWE+zFDco71SdV05XwFARvGFxHHs
	IE73Oz30LX7dMjnPj3PKPesO61ZJogrVoh+nchxQ=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 175619743776097.12088263774785; Tue, 26 Aug 2025 01:37:17 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Tue, 26 Aug 2025 01:37:17 -0700 (PDT)
Date: Tue, 26 Aug 2025 12:37:17 +0400
From: Askar Safin <safinaskar@zohomail.com>
To: "Alejandro Colomar" <alx@kernel.org>
Cc: "Aleksa Sarai" <cyphar@cyphar.com>,
	"Alexander Viro" <viro@zeniv.linux.org.uk>,
	"linux-api" <linux-api@vger.kernel.org>,
	"linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
	"David Howells" <dhowells@redhat.com>,
	"Christian Brauner" <brauner@kernel.org>,
	"linux-man" <linux-man@vger.kernel.org>
Message-ID: <198e5864132.1283ed42534579.7191562270325331624@zohomail.com>
In-Reply-To: <rxl7zzllf374j6osujwvpvbvsnrjwikoo5tj2o3pqntfjdmwps@isiyqms4s776>
References: <20250825154839.2422856-1-safinaskar@zohomail.com>
 <20250825154839.2422856-2-safinaskar@zohomail.com> <rxl7zzllf374j6osujwvpvbvsnrjwikoo5tj2o3pqntfjdmwps@isiyqms4s776>
Subject: Re: [PATCH v2 1/1] man2/mount.2: expand and clarify docs for
 MS_REMOUNT | MS_BIND
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr08011227c4a3178776148dd706e4aef700003b55986d7f03313633f8477e7c9bd0f59260cbafe4401d81c5:zu080112271c1d695e3c1ace35ad6fc9070000cce79072a7f3ae8edaf416d0d642432f4f406888972e25c1fb:rf0801122c63233b13838b3fd6ae20706600008e31637284141afb849e1e22d5fc63041d14fc538df8edae3ebedaff5370:ZohoMail

 ---- On Mon, 25 Aug 2025 23:13:05 +0400  Alejandro Colomar <alx@kernel.org> wrote --- 
 > Should we say "mount point" instead?  Otherwise, it's inconsistent with

d-user@comp:/rbt/man-pages$ grep -E -r -I -i 'mount point' /rbt/man-pages/man | wc -l
101
d-user@comp:/rbt/man-pages$ grep -E -r -I -i 'mount-point' /rbt/man-pages/man | wc -l
9
d-user@comp:/rbt/man-pages$ grep -E -r -I -i 'mountpoint' /rbt/man-pages/man | wc -l
4

My experiments show that "mount point" is indeed the most popular variant.

I changed all "mountpoint" to "mount point".

I decided to keep all "per-mount-point".

 > > +have its existing per-mount-point flags
 > > +cleared and replaced with those in
 > > +.I mountflags
 > > +when
 > > +.B MS_REMOUNT
 > > +and
 > > +.B MS_BIND
 > > +are specified.
 > 
 > Maybe reverse the sentence to start with this?

I decided simply to remove that "MS_REMOUNT and MS_BIND" part
(because it is already present in previous sentence).

 > > +This means that if
 > 
 > I would move the 'if' to the next line.

I moved it. But, please, next time do it youself.
I don't plan to become regular man-pages contributor.

I addressed all complains except for listed above and sent v3.

====
Askar Safin
https://types.pl/@safinaskar


