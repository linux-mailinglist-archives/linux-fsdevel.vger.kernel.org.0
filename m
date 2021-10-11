Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F4942975E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 21:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbhJKTNo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 15:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbhJKTNn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 15:13:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334F6C061570;
        Mon, 11 Oct 2021 12:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ftuJyAIkxX7N4Dz/v5CU90ZsxfI0kloQ5HQEKjjsC9M=; b=tXeFa3ISt/VDGSJDRaEEvR43kP
        KNm3e7FjPlzGc0rVjcTWihz4v0DUvUrreG75r3ChG2HDvi7Pq2x4Iik5Mh+NczNE9PCh2eFuYSaCy
        IGlzJt+h3jbz99GTgPgcreQ+fzxxHo137H0pOvsyc0X/VyVrPMzXDOJ03EzHKHDWlrfCNIMTjSjst
        xzuWQRwsGREcfyZENaluVObW8Yq7h67jkRlUM+MPGh/R0x5BK765Mgvs9L8bxL69NfruWIZ/1s+Vt
        CgdcAXVkRZTQ4LudKgo7B9a4xop7T0iIL/ieQlTgf5Jt0eC3Y96PNr51OJmr7KrncnYKT4aztOgz3
        bLXM+vTw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ma0i0-00ASpf-OY; Mon, 11 Oct 2021 19:11:36 +0000
Date:   Mon, 11 Oct 2021 12:11:36 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, tglx@linutronix.de, keescook@chromium.org,
        rostedt@goodmis.org, linux-spdx@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 03/12] selftests: add tests_sysfs module
Message-ID: <YWSMaIW1JRtottET@bombadil.infradead.org>
References: <20210927163805.808907-1-mcgrof@kernel.org>
 <20210927163805.808907-4-mcgrof@kernel.org>
 <alpine.LSU.2.21.2110071620130.19025@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2110071620130.19025@pobox.suse.cz>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 07, 2021 at 04:23:22PM +0200, Miroslav Benes wrote:
> On Mon, 27 Sep 2021, Luis Chamberlain wrote:
> 
> > This adds a new selftest module which can be used to test sysfs, which
> > would otherwise require using an existing driver. This lets us muck
> > with a template driver to test breaking things without affecting
> > system behaviour or requiring the dependencies of a real device
> > driver.
> > 
> > A series of 28 tests are added. Support for using two device types are
> > supported:
> > 
> >   * misc
> >   * block
> 
> I suppose the selftests will run for more than 45 seconds (default 
> kselftest timeout), so you probably also want to set timeout to something 
> sensible in tools/testing/selftests/sysfs/settings file (0 would disable 
> it).

Good catch, I'll use a default of 200, in practice for me this runs in
much less than that, about 110 seconds, so 200 should be good wiggle
room.

  Luis
