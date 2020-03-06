Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 514EA17C103
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 15:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgCFO4U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 09:56:20 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42262 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726674AbgCFO4T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:56:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583506578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VvNfBP6h/YjLYDbQgpAqGLfV7p/dFrBKdGIUKmuZy+w=;
        b=R1xKTAn6a4FkmHNLcv77uFzt5LAF/6wo5SJ0N88y+sqzJY9Worl4G5WAYWfcM7/OYFAjnu
        2iEkPwWcvd/xRuZqGvpu+KDfjkGZckkRja21LwwxMvbMP48PtPCFvbpoiV2yCArRMfJbEj
        tJv9jbfyOd6y+rvubUWORCczYCUQlXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-OA2bfNzCNW2ep838-KW2qg-1; Fri, 06 Mar 2020 09:56:16 -0500
X-MC-Unique: OA2bfNzCNW2ep838-KW2qg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E96A19251A7;
        Fri,  6 Mar 2020 14:56:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9AA985D9CD;
        Fri,  6 Mar 2020 14:56:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200306134407.zjiiieg3m6ce5uts@yavin>
References: <20200306134407.zjiiieg3m6ce5uts@yavin> <4e915f46-093b-c566-1746-938dbd6dcf62@samba.org> <3774367.1583430213@warthog.procyon.org.uk> <3786501.1583440507@warthog.procyon.org.uk>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     dhowells@redhat.com, Stefan Metzmacher <metze@samba.org>,
        linux-api@vger.kernel.org, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, christian.brauner@ubuntu.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Mark AT_* path flags as deprecated and add missing RESOLVE_ flags
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4041660.1583506572.1@warthog.procyon.org.uk>
Date:   Fri, 06 Mar 2020 14:56:12 +0000
Message-ID: <4041661.1583506572@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Aleksa Sarai <cyphar@cyphar.com> wrote:

> But please (for now) also reserve RESOLVE_NO_AUTOMOUNTS, which would
> apply the same restriction for all path components.

I'm not going to do that for the moment.  There will be objections if it isn't
wired up for at least something - but at the moment Al doesn't want people
going and making conflicting changes in fs/namei.c with what he's doing.

David

