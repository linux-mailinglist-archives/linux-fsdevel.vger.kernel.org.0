Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 360B1150235
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 09:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgBCIFe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 03:05:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35116 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbgBCIFe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 03:05:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=m2Jb1WvjWkt+IKFMUs3cGzOzvlivWGGcI1uIwec4iOI=; b=pPgLX0mh2wi1JRAs+IinpnMj1
        nFpigXQN8j032bw9tEdAvq+zfItIasj8EbP3Sl6b20vGN3Yc/QU2xz7a+418CKVpI7/tAaLjJmNG0
        Wcpu4jDcDUHLOHGYAnfrAiGe2F74eug1VWe5tjMwWdkMfJeI5r4JW8YQ4jrrTrjCqbqVHMWLsn2Gp
        wJoYBHjwPcpQLWkCmAdWKU5zf65PuTR1zwcfr5JEi6vn8/oAw6ALGpEBp++N4Yqr96U4W7KP14LLN
        a914aKKoPOrNds4TRe++tCRlEU79Ddf/9Cj/5p1EoFzqaylFHH0ZM/xgTPDRRzZycmQgd10f5aNK7
        d6ve+LziQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iyWjc-0008CT-3d; Mon, 03 Feb 2020 08:05:32 +0000
Date:   Mon, 3 Feb 2020 00:05:32 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.mitsubishielectric.co.jp>
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Mori.Takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp
Subject: Re: [PATCH 1/2] staging: exfat: remove DOSNAMEs.
Message-ID: <20200203080532.GF8731@bombadil.infradead.org>
References: <20200203163118.31332-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203163118.31332-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 04, 2020 at 01:31:17AM +0900, Tetsuhiro Kohada wrote:
> remove 'dos_name','ShortName' and related definitions.
> 
> 'dos_name' and 'ShortName' are definitions before VFAT.
> These are never used in exFAT.

Why are we still seeing patches for the exfat in staging?  Why are people
not working on the Samsung code base?
