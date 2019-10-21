Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB37DEE38
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 15:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbfJUNpu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 09:45:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57947 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728843AbfJUNpt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:45:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571665549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x4hyIpZYEVzfZMT5B+HxbYNt+qj8dKUgUsq44t28EZc=;
        b=AvurzjOcuwS6Uxdqj01mhIh3YEFSRm57ULX2qTsf+70ypmIiMBrU3vgqogEy0m5Y0bEZKk
        IuMEDldNXqlVlsp2i1C7iNXB7eJlU2rUhMQ5rtxLLYqrF90bIs3cNMls6a1CnO9B1KgZc4
        llW/QzkjLT47d6IaZ4wpFcj12WtFuNU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-bsB9U3iJMryrNLCs9bwM-A-1; Mon, 21 Oct 2019 09:45:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D239380183E;
        Mon, 21 Oct 2019 13:45:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-40.rdu2.redhat.com [10.10.121.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9528D60606;
        Mon, 21 Oct 2019 13:45:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <nycvar.YSQ.7.76.1910191518180.1546@knanqh.ubzr>
References: <nycvar.YSQ.7.76.1910191518180.1546@knanqh.ubzr>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Maxime Bizon <mbizon@freebox.fr>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] cramfs: fix usage on non-MTD device
MIME-Version: 1.0
Content-ID: <18922.1571665539.1@warthog.procyon.org.uk>
Date:   Mon, 21 Oct 2019 14:45:39 +0100
Message-ID: <18923.1571665539@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: bsB9U3iJMryrNLCs9bwM-A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Nicolas Pitre <nico@fluxnic.net> wrote:

> From: Maxime Bizon <mbizon@freebox.fr>
>=20
> When both CONFIG_CRAMFS_MTD and CONFIG_CRAMFS_BLOCKDEV are enabled, if
> we fail to mount on MTD, we don't try on block device.
>=20
> Fixes: 74f78fc5ef43 ("vfs: Convert cramfs to use the new mount API")
>=20
> Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
> Signed-off-by: Nicolas Pitre <nico@fluxnic.net>

Acked-by: David Howells <dhowells@redhat.com>

