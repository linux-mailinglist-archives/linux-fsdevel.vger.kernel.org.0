Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E17E37A6FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 14:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhEKMpt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 08:45:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40809 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230315AbhEKMpt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 08:45:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620737082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4o6Ffa69FMsQW/au0oF06r8P6K3EowOIgk81rhbEYjA=;
        b=aFdyKYP+bi3CUgFSSRIOrh0dQpG53QRmxiF+ZFb2bQp4fVG4/4LP/1oAcE9PbLkePbKDwg
        UgBeux5wZYiFGk4r9h1gFH+du/MNa64TuaVfuxTqcMiRSXLwrukh5tqs1zJBcMeoTMiUna
        uBED7L53rrK2ZDmZDbL7oo0eZRO7fR0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24--3vElt0XMX-g6IsiQlSJxw-1; Tue, 11 May 2021 08:44:40 -0400
X-MC-Unique: -3vElt0XMX-g6IsiQlSJxw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41360800FF0;
        Tue, 11 May 2021 12:44:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B8BC5D9E3;
        Tue, 11 May 2021 12:44:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <871rae24kv.fsf@suse.de>
References: <871rae24kv.fsf@suse.de> <87czu45gcs.fsf@suse.de> <YJPIyLZ9ofnPy3F6@codewreck.org> <87zgx83vj9.fsf@suse.de> <87r1ii4i2a.fsf@suse.de> <YJXfjDfw9KM50f4y@codewreck.org> <875yzq270z.fsf@suse.de>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     dhowells@redhat.com, Dominique Martinet <asmadeus@codewreck.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: 9p: fscache duplicate cookie
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2508105.1620737077.1@warthog.procyon.org.uk>
Date:   Tue, 11 May 2021 13:44:37 +0100
Message-ID: <2508106.1620737077@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Luis Henriques <lhenriques@suse.de> wrote:

> +		if (data->inode < inode)
> +			node = node->rb_left;
> +		else if (data->inode > inode)
> +			node = node->rb_right;

If you're just using a plain integer as the key into your debug tree, an
xarray, IDA or IDR might be easier to use.

David

