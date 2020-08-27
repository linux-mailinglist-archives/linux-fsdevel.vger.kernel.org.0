Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5349D254803
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 16:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgH0O5m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 10:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbgH0M0e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:26:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199EFC061235
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 05:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=hcl7PSpX8fKFD2jyhzt8CJl3EdD2lukVdJzKdsvQLsg=; b=T8w1TQn8yeQ2DzAajGsJIIusqY
        WX2M4621uVEVf3Nk7j+EQ4AI2HiFWnuPlY3eGNvVP9UMieabY7plGm6NN/vWnQI0iTarjKLuM3SdX
        L+qbrCAjvLa3Rf9WB9DeT6FU25/lv6OermhMKpL6jXjMPpHTkSmypYGabp26O3hFz6UawJ1nM38uF
        pTzpLBk17V1DOoki8S3NNyWTCZQqv5+i/dtVLBJPUa+Bja2f0xd1IUchgghf3aVafDt9xAMTlqNXb
        Dhlcl+bvciLEFO055DbDOADWGqwYJJ/Vq+eB1VVwMrHLjmddlCODqwbLeDkhXa1tMm2ZpNusU1ZEi
        rWRX3Wpg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBGyZ-00029w-JS; Thu, 27 Aug 2020 12:25:55 +0000
Date:   Thu, 27 Aug 2020 13:25:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Frank van der Linden <fllinden@amazon.com>,
        Dave Chinner <david@fromorbit.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: file forks vs. xattr (was: xattr names for unprivileged
 stacking?)
Message-ID: <20200827122555.GD14765@casper.infradead.org>
References: <20200824222924.GF199705@mit.edu>
 <3918915.AdkhnqkaGN@silver>
 <CAJfpegt9Pmj9k-qAaKxcBOjTNtV5XsTYa+C0s9Ui9W13R-dv8g@mail.gmail.com>
 <1803870.bTIpkxUbEX@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1803870.bTIpkxUbEX@silver>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 27, 2020 at 02:02:42PM +0200, Christian Schoenebeck wrote:
> What I could imagine as delimiter instead; slash-caret:
> 
>     /var/foo.pdf/^/forkname

Any ascii character is going to be used in some actual customer workload.
I suggest we use a unicode character instead.

/var/foo.pdf/💩/badidea

