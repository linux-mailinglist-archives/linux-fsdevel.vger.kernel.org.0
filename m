Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7922233086
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 12:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbgG3KrA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 06:47:00 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28206 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726819AbgG3KrA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 06:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596106018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZpJBVrfk7CBP+2x9tuVRq2yFi/n5laYEQwJk4+y6mA8=;
        b=N76ksBCZTSFQcbbISte1mvMExVHT6efxhLThUiu0SW8fU5QMA2vQhJhYJ+4M3aXTr6so/p
        791erLbEjxAx8LLfHu3uRK0HLTwBhUkwsXs+0sbg4Q+csbYvqlUxLHozgFDK1mqqnApW/M
        xdgCSs+Fl3horfPTm3HNb+X/aAyg4MQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-6b_sYAohM_epvOGm9Ig2HA-1; Thu, 30 Jul 2020 06:46:57 -0400
X-MC-Unique: 6b_sYAohM_epvOGm9Ig2HA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B140B18C63D3;
        Thu, 30 Jul 2020 10:46:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 654B619D7B;
        Thu, 30 Jul 2020 10:46:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <159562904644.2287160.13294507067766261970.stgit@warthog.procyon.org.uk>
References: <159562904644.2287160.13294507067766261970.stgit@warthog.procyon.org.uk>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, jarkko.sakkinen@linux.intel.com,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watch_queue: Limit the number of watches a user can hold
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <439875.1596106009.1@warthog.procyon.org.uk>
Date:   Thu, 30 Jul 2020 11:46:49 +0100
Message-ID: <439876.1596106009@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Could you consider taking this patch as a bugfix since the problem exists
already in upstream code?

David

