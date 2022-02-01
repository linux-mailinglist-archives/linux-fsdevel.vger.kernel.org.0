Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2884A5DFB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 15:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239067AbiBAONU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 09:13:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30786 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238761AbiBAONT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 09:13:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643724799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nrT/5L5qYMHdiH1OYbxOA/3ZZSuEj0xzzYPB+L6+4q8=;
        b=U+9eBju1EQWfBLZPMT2TmOuwXuveZhSOFgkbQz/4ubN9RIYpaGCR1+z3ZAuZ14EgXPqEKl
        eEuxu6r2Ei1BcJvvcwedZlOZEZq4Pf91NnQWLp9Bl+ahbLIOzJCr/jRSy3JaJMoIUU5YSW
        jmwHgN3rZtC9OOnIKW4snhutH1T+vwU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-79-wAukSB2EMM-ZNA2E0nQePQ-1; Tue, 01 Feb 2022 09:13:18 -0500
X-MC-Unique: wAukSB2EMM-ZNA2E0nQePQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EDB784DA41;
        Tue,  1 Feb 2022 14:13:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CCA9277D52;
        Tue,  1 Feb 2022 14:13:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <2ee1eb2b46a3bbdbde4244634586655247f5c676.camel@HansenPartnership.com>
References: <2ee1eb2b46a3bbdbde4244634586655247f5c676.camel@HansenPartnership.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     dhowells@redhat.com, lsf-pc@lists.linux-foundation.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] configfd as a replacement for both ioctls and fsconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1476916.1643724793.1@warthog.procyon.org.uk>
Date:   Tue, 01 Feb 2022 14:13:13 +0000
Message-ID: <1476917.1643724793@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> 
> If the ioctl debate goes against ioctls, I think configfd would present
> a more palatable alternative to netlink everywhere.

It'd be nice to be able to set up a 'configuration transaction' and then do a
commit to apply it all in one go.

David

