Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AF350B64F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 13:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447122AbiDVLqI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 07:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiDVLqI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 07:46:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24632546B5
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 04:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650627794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Ka4pkaIl0n0C8wRiVJB+Tf0N4jkuRhOTDXzmulvrko=;
        b=N7lpY4NMtlZ9NF3FU+/vhJqEmLCiE1JW9NxLR2YrakY9j1GhBYkAOvSo2VJ9Iec2uXo/IP
        Lt/of2Bbk9dMSmpAqySogwLaeFFNVO1wBNCXVS4x3B6rVCiYccC9zoWzDO68ck1lp/iwbo
        fIPk6C/zOCLU+4bQ6Ds85U3RZXfrU8Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-43-2aQCrlSrPfuy5v4vWNiTYg-1; Fri, 22 Apr 2022 07:43:10 -0400
X-MC-Unique: 2aQCrlSrPfuy5v4vWNiTYg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFC621C05AB6;
        Fri, 22 Apr 2022 11:43:09 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 567B3C33AE8;
        Fri, 22 Apr 2022 11:43:09 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Matthew Wilcox" <willy@infradead.org>
Cc:     lsf-pc@lists.linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: LSF/MM/BPF 2022: Running BOF
Date:   Fri, 22 Apr 2022 07:43:08 -0400
Message-ID: <15847F8A-5246-4634-ABBE-9C05AA3CBF34@redhat.com>
In-Reply-To: <Yl7TUDtLcrhXcp1g@casper.infradead.org>
References: <Yl7TUDtLcrhXcp1g@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 19 Apr 2022, at 11:20, Matthew Wilcox wrote:

> As in the past few years, let's hold a running BOF.
>
> I propose meeting in the lobby of the Margaritaville hotel at 6:15 for
> a 6:30 departure for an hour-long run on Monday, Tuesday and Wednesday
> mornings.  I'm assuming breakfast will be 8-9am and sessions start at 9am.
> Pace will be determined by whoever shows up.
>
> We're only a mile from the North Lykken north Trailhead.
> Other trails are a little more distant.  I've been reading
> http://www.hiking-in-ps.com/the-north-lykken-trail/ (note this map is
> for the south trailhead of the North Lykken trail).  I haven't been
> to this area in 30 years and I have no idea what the trails are like,
> so if somebody has local information, that would be great.
>
> I note that the room rate includes complimentary bicycle rentals.  If
> we want to, we could cycle to various other local trails.

I'm in unless I'm trying to run in the PM.  I've got a tentative run/explore
of one of the slot canyons about an hour away if I can swing it (painted
canyon, ladder canyon, I may have to borrow a car from someone), and would
be nice to try to get up into Mt San Jacinto park as well.

I'm interested in getting some trail and elevation, but I've not run out
there yet and will need to scope out what's possible when I get there.

Ben

