Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6B350718B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 17:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353758AbiDSPXg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 11:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349921AbiDSPXf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:23:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8202252C;
        Tue, 19 Apr 2022 08:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=3uTLPiJrypIFbJrBbJWzyUq8lrOCNCTROK2VPYKwjoA=; b=CqToA9mnHuh9R675pN4UgpoBZg
        gfu2d3mM2Owwa+3GmAofOGXIkBfmV/sB9AXgipt84d4jtCDfNjNc/8T8xR3fiWIShDCd7CK0Ivf6B
        SevxsUBQjZV0HfnnYjW8xaNKIu6jMGOMDdZD0K2ZiGMUDUvbYmNkYn6Zd7S/5ZLs/MH6CpU3qE/31
        Jag8nwx17tjwDTXsxb5aBbZIfhJzWnYXKEItolLqGqNB/m6cKSLsCjjUzmF1oz+/Hpo28sifNg4wa
        xgDt0VPEu/+w+PC5KVfDcP3sCIjVymIn8khwth399ruFBjMc86W3INsvi8dunb11Q+a9560yXNE/G
        cUsLfxfA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngpeq-003DM3-Ew; Tue, 19 Apr 2022 15:20:48 +0000
Date:   Tue, 19 Apr 2022 16:20:48 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     lsf-pc@lists.linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: LSF/MM/BPF 2022: Running BOF
Message-ID: <Yl7TUDtLcrhXcp1g@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As in the past few years, let's hold a running BOF.

I propose meeting in the lobby of the Margaritaville hotel at 6:15 for
a 6:30 departure for an hour-long run on Monday, Tuesday and Wednesday
mornings.  I'm assuming breakfast will be 8-9am and sessions start at 9am.
Pace will be determined by whoever shows up.

We're only a mile from the North Lykken north Trailhead.
Other trails are a little more distant.  I've been reading
http://www.hiking-in-ps.com/the-north-lykken-trail/ (note this map is
for the south trailhead of the North Lykken trail).  I haven't been
to this area in 30 years and I have no idea what the trails are like,
so if somebody has local information, that would be great.

I note that the room rate includes complimentary bicycle rentals.  If
we want to, we could cycle to various other local trails.

