Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD1B233796
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 19:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbgG3RTn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 13:19:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47552 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727072AbgG3RTn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 13:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596129582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yfgpEad35QlSnKs/MBOCUF8OTtEP6rCnc2IsO7uLItY=;
        b=PmaYikEAhKai4wSOW7s00YEWZGjELfndB6Kb/KwaRkhNpF5IW3c/gOWJgwCGaNnIlTTFu+
        hs5k+c/Dyy3iLQgLG7wFve+QddGaKFMG83MiPhHqBZ8uEoT4p6m59cNbEsVCL227wXOJV3
        jl4lFirypf8VE6l7eTqD0Pu2r83xk2s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-XdgRvRDMN0yJ3P4Ns-mDBQ-1; Thu, 30 Jul 2020 13:19:39 -0400
X-MC-Unique: XdgRvRDMN0yJ3P4Ns-mDBQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71CCD79EC2;
        Thu, 30 Jul 2020 17:19:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 038325FC31;
        Thu, 30 Jul 2020 17:19:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <439876.1596106009@warthog.procyon.org.uk>
References: <439876.1596106009@warthog.procyon.org.uk> <159562904644.2287160.13294507067766261970.stgit@warthog.procyon.org.uk>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, jarkko.sakkinen@linux.intel.com,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watch_queue: Limit the number of watches a user can hold
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <521561.1596129576.1@warthog.procyon.org.uk>
Date:   Thu, 30 Jul 2020 18:19:36 +0100
Message-ID: <521562.1596129576@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> Could you consider taking this patch as a bugfix since the problem exists
> already in upstream code?

Alternatively, I can include it in a set with the mount notifications.

David

