Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CF923CD1A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 19:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgHERUD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 13:20:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38456 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728777AbgHERTD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kZTBrunrXrFalb8MiTTYY4li8BGfP27s1yfj7FYVgAs=;
        b=H57vQJgbJYH+pX6ni1jRJAdarIIAqoo8Xcrix3Hvslhd+xFefYx19jQf2k8yIQcTI1Uorc
        hcbdWymPhD3TwqxuUmbEm1agkDk2KZtO9QZJ1/3qG/GG3f0ilxCqQqnjv1bPnTVPtI4PbH
        wAJXl2VxvTjr2VA3MDxgKgcgFaDhGI0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-Y4-7UuimPtOA66nnqm_UqQ-1; Wed, 05 Aug 2020 13:18:56 -0400
X-MC-Unique: Y4-7UuimPtOA66nnqm_UqQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A38031B18BCD;
        Wed,  5 Aug 2020 17:18:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DBA95D9DC;
        Wed,  5 Aug 2020 17:18:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAKgNAkgYZ4HrFpOW_n8BshbR8d=03wetmxX2zNv7hX4ZmeQPmg@mail.gmail.com>
References: <CAKgNAkgYZ4HrFpOW_n8BshbR8d=03wetmxX2zNv7hX4ZmeQPmg@mail.gmail.com> <CAKgNAkjyXcXZkEczRz2yvJRFBy2zAwTaNfyiSmskAFWN_3uY1g@mail.gmail.com> <2007335.1595587534@warthog.procyon.org.uk>
To:     mtk.manpages@gmail.com
Cc:     dhowells@redhat.com, Petr Vorel <pvorel@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Mount API manual pages
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2329755.1596647924.1@warthog.procyon.org.uk>
Date:   Wed, 05 Aug 2020 18:18:44 +0100
Message-ID: <2329756.1596647924@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Michael Kerrisk (man-pages) <mtk.manpages@gmail.com> wrote:

> This is just a reminder mail :-).

Yep - I haven't forgotten.  Spent a chunk of time arguing with reinventors and
arguing with a failing dishwasher.  I have some other manpages that I'm
sprucing up too for the notifications stuff.

David

