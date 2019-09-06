Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4F1BAB8BA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 15:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390555AbfIFNAR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 09:00:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389936AbfIFNAR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 09:00:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A821C3086258
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2019 13:00:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-255.rdu2.redhat.com [10.10.120.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E44566061E;
        Fri,  6 Sep 2019 13:00:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <9998d31a-7594-761c-a1a6-22b3ee96e736@redhat.com>
References: <9998d31a-7594-761c-a1a6-22b3ee96e736@redhat.com> <7020be46-f21f-bd05-71a5-cb2bc073596b@redhat.com> <29446.1567761462@warthog.procyon.org.uk>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     dhowells@redhat.com, fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fs: fs_parser: remove fs_parameter_description name field
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18174.1567774811.1@warthog.procyon.org.uk>
Date:   Fri, 06 Sep 2019 14:00:11 +0100
Message-ID: <18175.1567774811@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 06 Sep 2019 13:00:17 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Sandeen <sandeen@redhat.com> wrote:

> My patch does exactly that, right?

Sorry, I missed that.  Distracted by Linus.

David
