Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD8282B24
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 07:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731674AbfHFFlS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 01:41:18 -0400
Received: from verein.lst.de ([213.95.11.211]:53292 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfHFFlS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 01:41:18 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 22F5B68B05; Tue,  6 Aug 2019 07:41:16 +0200 (CEST)
Date:   Tue, 6 Aug 2019 07:41:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel@vger.kernel.org, hch@lst.de, adilger@dilger.ca,
        jaegeuk@kernel.org, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 8/9] Use FIEMAP for FIBMAP calls
Message-ID: <20190806054115.GJ13409@lst.de>
References: <20190731141245.7230-1-cmaiolino@redhat.com> <20190731141245.7230-9-cmaiolino@redhat.com> <20190731232254.GW1561054@magnolia> <20190731233133.GB1561054@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731233133.GB1561054@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Darrick, and chance to not send out a double full quote?  I just can't
not find the actual information in this mail even if I try.
