Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D22358D9FE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 15:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244695AbiHIN6j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 09:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243576AbiHIN6g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 09:58:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C43BBD7
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Aug 2022 06:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660053514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+iBX2CUEKV5L8oNC+j4le4zVCb3jpztFMMY/uHRCYck=;
        b=Q7ZEqRNzHU9Fj5YubLFsBxoPuiD143Ory+o0cbeHUbCjXCi/xr2XpYfSRG+7LVADeBFSTG
        gBzY4xrElBttaTrxQMThcla1CUJS1+AtzKa3w1sUnifZVLFDXZ08OHZ2Lzu7or5vG9+ORM
        Sd3h0TEM+guHeTdfUo3+e42os++AYyk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-45-l1jlXfT-M9eGcztM8uR2LQ-1; Tue, 09 Aug 2022 09:58:28 -0400
X-MC-Unique: l1jlXfT-M9eGcztM8uR2LQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 417818039A6;
        Tue,  9 Aug 2022 13:58:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7CB95492C3B;
        Tue,  9 Aug 2022 13:58:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <431242.1660051645@warthog.procyon.org.uk>
References: <431242.1660051645@warthog.procyon.org.uk>
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        jlayton@kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] fscache: Invalidation fix and new tracepoint
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <433855.1660053506.1@warthog.procyon.org.uk>
Date:   Tue, 09 Aug 2022 14:58:26 +0100
Message-ID: <433856.1660053506@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Bah...  I forgot to set the subject line.

David

