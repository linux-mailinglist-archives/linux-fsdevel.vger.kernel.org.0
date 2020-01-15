Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28C3A13CECF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 22:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbgAOVUI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 16:20:08 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49555 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729259AbgAOVUG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 16:20:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579123206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/9aI+XysB2K8PkWSb2xgoTza9SmIoeznTkyTmdcAhMI=;
        b=LsKYN4MzHgT8eyx3aaNnqkqULZwjMOL+GhwuhwCEDENefbieZO+XwzSlkMthEM9irWf5dL
        UVVOZ/4iEVLMlspxw8ZmsZvG0HJUAQLno+jXEPGOJPqrOxPTihsv5ocne6ovcc6yGVfdzp
        OYpjTX4zS+j4qKm6RNC6t4GvLg2TuwY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-63FEipuPOjSs30P70YfqlA-1; Wed, 15 Jan 2020 16:20:02 -0500
X-MC-Unique: 63FEipuPOjSs30P70YfqlA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BABD92FA0;
        Wed, 15 Jan 2020 21:20:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-52.rdu2.redhat.com [10.10.120.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6661160BE0;
        Wed, 15 Jan 2020 21:20:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAH2r5msP9W5Jd+=W0oFnEbqzj5dYEzdiydSoX0m0sdZ5KOF-zQ@mail.gmail.com>
References: <CAH2r5msP9W5Jd+=W0oFnEbqzj5dYEzdiydSoX0m0sdZ5KOF-zQ@mail.gmail.com> <157432403818.17624.9300948341879954830.stgit@warthog.procyon.org.uk>
To:     Steve French <smfrench@gmail.com>
Cc:     dhowells@redhat.com, Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] cifs: Don't use iov_iter::type directly
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <26196.1579123199.1@warthog.procyon.org.uk>
Date:   Wed, 15 Jan 2020 21:19:59 +0000
Message-ID: <26197.1579123199@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Steve French <smfrench@gmail.com> wrote:

> tentatively merged into cifs-2.6.git for-next (pending more of the
> usual automated testing we do with the buildbot)

Thanks.

David

