Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BE667F795
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Jan 2023 12:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjA1Lf3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Jan 2023 06:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbjA1Lf2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Jan 2023 06:35:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F832E824
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Jan 2023 03:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674905680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vhnwvkrxI3b8cKGQbCxF3BGuyIUNQ+hsLoVh9xY6Qas=;
        b=aT5DUwDyFl6RxQ5y/3Hs9ZXwrLzAIVQZcB7PW1BZKUpoHT4oZlmZrvejciMiEPsc7ti8FJ
        wfsd6xH+wt+pceAbuAzP613GAMuVx5+iQd0aXXZ3IGw4F3fwUZre4e0NUb6dL7k1coen0e
        NDfQJeP89TM8FD7ZN3tW6nQUAwwxbDc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-462-GRhoCibNOKq_tWOyR7Wcnw-1; Sat, 28 Jan 2023 06:34:36 -0500
X-MC-Unique: GRhoCibNOKq_tWOyR7Wcnw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B942229AA3B8;
        Sat, 28 Jan 2023 11:34:35 +0000 (UTC)
Received: from T590 (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D86014171BE;
        Sat, 28 Jan 2023 11:34:27 +0000 (UTC)
Date:   Sat, 28 Jan 2023 19:34:22 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
Cc:     Viacheslav Dubeyko <slava@dubeyko.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        lsf-pc@lists.linux-foundation.org, andreas@metaspace.dk
Subject: Re: [External] [LSF/MM/BPF BoF] Session for Zoned Storage 2023
Message-ID: <Y9UIPsp479CysMmX@T590>
References: <F6BF25E2-FF26-48F2-8378-3CB36E362313@dubeyko.com>
 <Y7h0F0w06cNM89hO@bombadil.infradead.org>
 <4CC4F55E-17B3-47E2-A8C5-9098CCEB65D6@dubeyko.com>
 <5DF10459-88F3-48DA-AEB2-5B436549A194@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5DF10459-88F3-48DA-AEB2-5B436549A194@bytedance.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 06, 2023 at 05:56:24PM -0800, Viacheslav A.Dubeyko wrote:
> 
> 
> > On Jan 6, 2023, at 11:30 AM, Viacheslav Dubeyko <slava@dubeyko.com> wrote:
> > 
> > 
> > 
> >> On Jan 6, 2023, at 11:18 AM, Luis Chamberlain <mcgrof@kernel.org> wrote:
> >> 
> >> On Fri, Jan 06, 2023 at 11:17:19AM -0800, Viacheslav Dubeyko wrote:
> >>> Hello,
> >>> 
> >>> As far as I can see, I have two topics for discussion.
> >> 
> >> What's that?
> > 
> > I am going to share these topics in separate emails. :)
> > 
> > (1) I am going to share SSDFS patchset soon. And topic is:
> > SSDFS + ZNS SSD: deterministic architecture decreasing TCO cost of data infrastructure.
> > 
> > (2) Second topic is:
> > How to achieve better lifetime and performance of caching layer with ZNS SSD?
> > 
> 
> I think we can consider such discussions:
> (1) I assume that we still need to discuss PO2 zone sizes?
> (2) Status of ZNS SSD support in F2FS, btrfs (maybe, bcachefs and other file systems)
> (3) Any news from ZoneFS (+ ZenFS maybe)?
> (4) New ZNS standard features that we need to support on block layer + FS levels?
> (5) ZNS drive emulation + additional testing features?

ZNS drive emulation can be done as one ublk target(userspace
implementation with ublk driver extension), and it was discussed before:

https://github.com/ming1/ubdsrv/pull/28


Thanks, 
Ming

