Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C49F0A6158
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 08:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfICGYO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 02:24:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55242 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfICGYO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 02:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=klPLnvUccpQZCH53OTFKR/8SWIz98cjkWp1cNaTwaYM=; b=aqUrBKoGkBk7RUTs21xZC4EVv
        9k6eFLV+fp4QiCehIZ4ZlNYiwqFizUuP/T6KN2VWtM5ELjHGBRn2vKIIxLPAD8bxMvHLEQ5QvGKX6
        //PJXptSFd6m/ndGn2oMdcE6+YS5o/T21eeAtaVB1YmCpW1EsU6A2+zWzlhFPW7SDsphSX8EvWAuk
        8SyBaDUTz2YOm0vU0Z9oVWzzJGfBFNpzGrYtmH62bNb291Ohud2hV7/cGrEG5NqHQzDE4RZPDz7nV
        5yOo8/ed+TfQepmmDHJ+noMZxo2XL+wM2qduty9nCxmzMGX+dXjBnTS070R3pubpCdqmKB5luxqUr
        p3ON6jnig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i52Ed-00027p-Uv; Tue, 03 Sep 2019 06:24:11 +0000
Date:   Mon, 2 Sep 2019 23:24:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Dave Chinner <david@fromorbit.com>,
        Hannes Reinecke <hare@suse.de>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH V4] fs: New zonefs file system
Message-ID: <20190903062411.GA7944@infradead.org>
References: <20190826065750.11674-1-damien.lemoal@wdc.com>
 <BYAPR04MB5816E881D9881D5F559A3947E7B90@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20190903032601.GV5354@magnolia>
 <20190903061602.GB26583@infradead.org>
 <BYAPR04MB5816D246389AAFD484D600C0E7B90@BYAPR04MB5816.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB5816D246389AAFD484D600C0E7B90@BYAPR04MB5816.namprd04.prod.outlook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 06:21:38AM +0000, Damien Le Moal wrote:
> On 2019/09/03 15:16, Christoph Hellwig wrote:
> > On Mon, Sep 02, 2019 at 08:26:01PM -0700, Darrick J. Wong wrote:
> >>
> >> Given that the merge window apparently won't close until Sept. 29, that
> >> gives us more time to make any more minor tweaks.
> > 
> > I think 5.3 final should be out at about Sep 15.  Isn't that the
> > traditional definition of closing the merge window?
> > 
> 
> If we have an rc8, yes, 5.3 final will be on Sep 15. And then the merge window
> for 5.4 opens for 2 weeks until Sep 29, no ?

I've always considered the merge window the time to queue up patches
in the maintainer trees, which would end with the release of the
previous release.
