Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139BD6AA81E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Mar 2023 06:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjCDFED (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Mar 2023 00:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCDFEC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Mar 2023 00:04:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECCB20051;
        Fri,  3 Mar 2023 21:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=3KUOIEuDKyOHxMbucNAykOCAoCC6boXcHa1Piw6R6Zo=; b=q0t5NYZ0s0uZSFwaYIKPlHAgBG
        Fh/YpnJ1T7/9vUHeow3hD7Dik99DlmvRByFkcfQZwxvA6KtYG5XM5G0U6uZ/r4FBBtIByb9OqDdZG
        vQssjkyGhGkTluG3K95ZFHJKSynL14+TSOi1HkppE1tkOTxmsdhcmAvO4sGTy0QJthwNdwQFrXy0t
        Vn7bD5YMBPbFmyeWmpANMe5iCD8vq/cl2FY5611Tudn/B2YxWnlPK/CUqW5OsPJH3Ffc5YQwZem1E
        dRMzau6dzmCdGuBED3iNxx1GGRhJd5yy4hQDtKNFt7umUM+SNCpdQCDvbqWeAne9KSxum6aBNAzoN
        sxvPLyWA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pYK3l-003er5-Gy; Sat, 04 Mar 2023 05:03:53 +0000
Date:   Sat, 4 Mar 2023 05:03:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Subject: [LSF/MM/BPF] Running BOF
Message-ID: <ZALROVnC+GDXsBne@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sunday May 7th is the Vancouver Marathon, and both Josef and I are
registered.  As such, neither of us may be feeling much like joining
or leading a run.  If anyone else is interested in participating,
https://bmovanmarathon.ca/ offers 8km and 21.1km races as well.  If you
just want a spot of morning exercise, I can suggest routes, but will
probably not join you.

For those concerned about how the marathon will affect getting around
Vancouver, you can see the various course maps:

https://bmovanmarathon.ca/marathon#course (8:30am-3pm)
https://bmovanmarathon.ca/halfmarathon#course (7am-11am)
https://bmovanmarathon.ca/8km#course (9:30am - 11am)

Don't expect to walk around Stanley Park until the marathon is over.
The Skytrain from the airport will be largely unaffected (possibly
infested with sweaty runners).  Bus routes may have diversions in place,
but the roads will open once runners are no longer using that particular
stretch, so eg Cambie & 49th will reopen to traffic quite early while
Pacific & Georgia will remain closed for much of the day.

If you want to come out & cheer for Josef and/or myself, let us know
and we can suggest good spots.
