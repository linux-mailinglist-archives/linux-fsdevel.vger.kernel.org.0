Return-Path: <linux-fsdevel+bounces-59105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C41EFB34729
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 18:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D641A885FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 16:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DFE301006;
	Mon, 25 Aug 2025 16:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="Z2mbH88b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8D22FF643;
	Mon, 25 Aug 2025 16:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756139003; cv=pass; b=fg3FraZ3yd8utCAAbOysweTRAkFfQ0LDSAGwRwNW+mV3P6HS4Wlo5fKUn55R2vQTJd+O3W6RNYCwkYhEMs3NGRDFqre3rModsK2MdJ7DLXiHm/uncaxQvgmzJ6pE67ManPJnlWeWhkZxSRswn4CK4vQdxbBKMFmYBeZ+kmTsxW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756139003; c=relaxed/simple;
	bh=Ot3Cby7vnWjdS324TAkSDK/FRhMj+hur58Pfr1nvpBE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=lBuxErxIQhxPsGpy4NUphUxvV59CVbFLTHxhEHkuem09dR3bjfvLrDSnQoAhakGsEaLX1XS1e3fawWyyWZ9hckG5o/RBY4MNfR4R5l4Cvzc0JUbhSv3ItzCpiLpoHuqpWtwwQkJAVYX1seHbjs+VwL5GFGWXpeG2it5v3eSmeD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=Z2mbH88b; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1756138977; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SQtasbswibAJ4WMRqmVEvIJqktnSAoEOL3OpdtSqDA8RGWKfUTEv69NnZ9/WqdCXa9I309MbEdRHunNNvUbWJPLcpczE6g4gQ3k8Rx9MNgliDubxkPbv0e+LLPaYRNGx1Ts8L5ZKCCdA29l0KzHVvujMcdCOrS37Wxa0cj3zdio=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756138977; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KM1jORzEtfwKNV4NwQFUqoNRg3Nu+/yOFx85Kkh0vk4=; 
	b=XrH3esGSyj1Pxkh0V/mLHVfQAPQXJI3OytHNDYG2z1pFPKZ4MvZ1gzCwM9tu3g0qej1YU4LOhaDrjMexjAbT8Eq4wMWjc/l9epaHjwzK4uTtAL2H95CnuV56yuWKCWw2c9gF3QRzcuQUYgC98bmnnsbSQkdQgR1Pw1DfHukAYQk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756138977;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=KM1jORzEtfwKNV4NwQFUqoNRg3Nu+/yOFx85Kkh0vk4=;
	b=Z2mbH88bKtxQtN5eXIOoUIoHDQURn9y+gPLlnDT1q9ojFTe5U2Rdp3tIfFHG8s9+
	eE4YYve7JUxFcN7fS9OTS+ECy/RONyIdolp2dSVlnWGQqXrh8Ezab9JaBbD2KVhuap6
	fNZ6BDa2KWdpPyEBnD6JUkaJQawOLP5zmN04KoVY=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1756138975381478.39810192964376; Mon, 25 Aug 2025 09:22:55 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Mon, 25 Aug 2025 09:22:55 -0700 (PDT)
Date: Mon, 25 Aug 2025 20:22:55 +0400
From: Askar Safin <safinaskar@zohomail.com>
To: "Aleksa Sarai" <cyphar@cyphar.com>
Cc: "Alejandro Colomar" <alx@kernel.org>,
	"Michael T. Kerrisk" <mtk.manpages@gmail.com>,
	"Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Jan Kara" <jack@suse.cz>,
	"G. Branden Robinson" <g.branden.robinson@gmail.com>,
	"linux-man" <linux-man@vger.kernel.org>,
	"linux-api" <linux-api@vger.kernel.org>,
	"linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"David Howells" <dhowells@redhat.com>,
	"Christian Brauner" <brauner@kernel.org>
Message-ID: <198e20a3088.ef79515d27409.5672203109742133398@zohomail.com>
In-Reply-To: <2025-08-22.1755869779-quirky-demur-grunts-mace-Hoxz0h@cyphar.com>
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
 <20250809-new-mount-api-v3-5-f61405c80f34@cyphar.com>
 <198d1f2e189.11dbac16b2998.3847935512688537521@zohomail.com> <2025-08-22.1755869779-quirky-demur-grunts-mace-Hoxz0h@cyphar.com>
Subject: Re: [PATCH v3 05/12] man/man2/fspick.2: document "new" mount API
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
Feedback-ID: rr08011227d6e3807cdfc5cfa01b04b0b00000cc4a99c65cf763561414276e55d6c27b40f61f457bd2718012:zu08011227d5b102457715986c01d227670000a0501beb61a5fc231420d02b2f604cf344dc5aabca20522440:rf0801122ce5c664ea73491759ac9acb390000b7dc1f0dc6587399277118a6be2d8a2118936d7af68d3ae4aa4ddff9747e:ZohoMail

 ---- On Fri, 22 Aug 2025 17:40:18 +0400  Aleksa Sarai <cyphar@cyphar.com> wrote --- 
 > On 2025-08-22, Askar Safin <safinaskar@zohomail.com> wrote:
 > >  ---- On Sat, 09 Aug 2025 00:39:49 +0400  Aleksa Sarai <cyphar@cyphar.com> wrote --- 
 > >  > +The above procedure is functionally equivalent to
 > >  > +the following mount operation using
 > >  > +.BR mount (2):
 > > 
 > > This is not true.
 > > 
 > > fspick adds options to superblock. It doesn't remove existing ones.
 > 
 > fspick "copies the existing parameters" would be more accurate. I can
 > reword this, but it's an example and I don't think it makes sense to add
 > a large amount of clarifying text for each example.

I suggest adding "but mount(2) clears existing parameters here, and fspick/fsconfig doesn't".

--
Askar Safin
https://types.pl/@safinaskar


