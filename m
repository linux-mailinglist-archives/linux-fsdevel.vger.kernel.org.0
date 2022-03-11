Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DD84D61A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 13:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345522AbiCKMhW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 07:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239437AbiCKMhW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 07:37:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F24931B45E6
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Mar 2022 04:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647002178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UKVzSKeZMycHkCzJ/H7Xt/yUOfRzsg+N9RfGNa9T9b4=;
        b=ihqEGKfY4zPT1zGVWPi1kPYDfbLRxA/n+pekUknx2qlJpV05i76zQcV29H3IQY3a7LPbBr
        7ESmAERUsWjbHGXRbrvO0H9/00NX2wwFAQAckG0RyiGus4eaF4p/0g1b8jtqB5v8ZM8GkS
        jFObwohPaxyT1I5Pkzl/dJcIljIXqtg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-mt5AQL_AOreHGHjfKihEvw-1; Fri, 11 Mar 2022 07:36:14 -0500
X-MC-Unique: mt5AQL_AOreHGHjfKihEvw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA90D801AFE;
        Fri, 11 Mar 2022 12:36:13 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.16.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9828E68D94;
        Fri, 11 Mar 2022 12:36:13 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 31DC7223A46; Fri, 11 Mar 2022 07:36:13 -0500 (EST)
Date:   Fri, 11 Mar 2022 07:36:13 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Enabling change notification for network and
 cluster fs
Message-ID: <YitCPVmurnC5Re9D@redhat.com>
References: <CAH2r5mt9OfU+8PoKsmv_7aszhbw-dOuDCL6BOxb_2yRwc4HHCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5mt9OfU+8PoKsmv_7aszhbw-dOuDCL6BOxb_2yRwc4HHCw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 23, 2022 at 11:16:33PM -0600, Steve French wrote:
> Currently only local events can be waited on with the current notify
> kernel API since the requests to wait on these events is not passed to
> the filesystem.   Especially for network and cluster filesystems it is
> important that they be told that applications want to be notified of
> these file or directory change events.
> 
> A few years ago, discussions began on the changes needed to enable
> support for this.   Would be timely to finish those discussions, as
> waiting on file and directory change events to network mounts is very
> common for other OS, and would be valuable for Linux to fix.

If this topic gets selected for discussion, I will be interested in
joining the conversation.

Vivek
> 
> -- 
> Thanks,
> 
> Steve
> 

