Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC2A162452
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 11:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgBRKN2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 05:13:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37656 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgBRKN1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 05:13:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description;
        bh=klTasm9LzG4RoLivUD2OrerRSmXKijdCremdXLEBvh0=; b=d/MdY8cGRwIIMHUhEvnXgfqz06
        HdKW+VCqQ6b4XRRaiTe6RIUcQMVKB1BtGQKfWhc4FIv75+rkDeVGNeycCn2X105vziKkk4fZEBmIG
        CFe5Jwehv4WpArBNCOsbI7y2iR3WCwnmH2SQDA0ttCDvkyOq6yXcRJYwC1AHUODAReSTsPIRM5xhT
        JetUMlXdAY6+HRm6IuLKv018N2XqlwB+rHxWmOhtvtcvOPCfCzpp2SHRSjxzeAqMFR2WBMAnnCfrR
        x4nH2WM+A6TpjsqiqPI9j7+z9seTK5PxV0LjRswFXGMdDvJGlIdDzfOZE5DrsbgwCVt9UN9esniUy
        Psr6buFQ==;
Received: from ip-109-41-129-189.web.vodafone.de ([109.41.129.189] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3zsd-0007eU-07; Tue, 18 Feb 2020 10:13:27 +0000
Date:   Tue, 18 Feb 2020 11:13:23 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>
Subject: Re: [PATCH 43/44] docs: filesystems: convert udf.txt to ReST
Message-ID: <20200218111138.4e387143@kernel.org>
In-Reply-To: <20200218071205.GC16121@quack2.suse.cz>
References: <cover.1581955849.git.mchehab+huawei@kernel.org>
        <2887f8a3a813a31170389eab687e9f199327dc7d.1581955849.git.mchehab+huawei@kernel.org>
        <20200218071205.GC16121@quack2.suse.cz>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Em Tue, 18 Feb 2020 08:12:05 +0100
Jan Kara <jack@suse.cz> escreveu:

> On Mon 17-02-20 17:12:29, Mauro Carvalho Chehab wrote:
> > - Add a SPDX header;
> > - Add a document title;
> > - Add table markups;
> > - Add lists markups;
> > - Add it to filesystems/index.rst.
> >=20
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org> =20
>=20
> Thanks! You can add:
>=20
> Acked-by: Jan Kara <jack@suse.cz>

Thanks for reviewing it!
=20
> and I can pickup the patch if you want.

=46rom my side, it would be ok if you want to pick any patches from this seri=
es.

Still, as they all touch Documentation/filesystems/index.rst, in order
to avoid (trivial) conflicts, IMO the best would be to have all of them
applied at the same tree (either a FS tree or the docs tree).

Cheers,
Mauro
