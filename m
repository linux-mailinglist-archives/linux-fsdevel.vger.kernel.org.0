Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B06F34A33D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 16:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbfFROBr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jun 2019 10:01:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46190 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729163AbfFROBr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jun 2019 10:01:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A2D830C1205;
        Tue, 18 Jun 2019 14:01:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-57.rdu2.redhat.com [10.10.120.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE17E7D933;
        Tue, 18 Jun 2019 14:01:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <d88b3276-a81a-d5a6-76d6-1a01376aa31c@gmail.com>
References: <d88b3276-a81a-d5a6-76d6-1a01376aa31c@gmail.com> <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk> <155905647369.1662.10806818386998503329.stgit@warthog.procyon.org.uk>
To:     Alan Jenkins <alan.christopher.jenkins@gmail.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, raven@themaw.net,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
Subject: Re: [PATCH 25/25] fsinfo: Add API documentation [ver #13]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18934.1560866496.1@warthog.procyon.org.uk>
Date:   Tue, 18 Jun 2019 15:01:36 +0100
Message-ID: <18935.1560866496@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 18 Jun 2019 14:01:47 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Alan Jenkins <alan.christopher.jenkins@gmail.com> wrote:

> > +    eleemnts in the FSINFO_ATTR_MOUNT_CHROOT list.
> 
> FSINFO_ATTR_MOUNT_CHROOT -> FSINFO_ATTR_MOUNT_CHILDREN

I've applied your changes.

David
