Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C88A6460C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 16:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbfFNOaz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jun 2019 10:30:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55502 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbfFNOaz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=g+j545IMwIJikYLXl8ImiYVIWrJ6ceFqhokOAsJBX7s=; b=cM786c65V4kkuIngazZnMLV984
        naip0mPWhZac9mKV9KODwN08xWW4C000ncgC8+c0HPnIlOHcIATtO/rCFwxw70GeCrODf9MynGlvh
        6m38ZTtpfwldKgVCKRdbotYqvsYbdCsBJnRgnSqK+drvHDChY7ql/bSEhL4ZbIMeobeyLLPzerQfm
        xHBc8WISsqWEavTN7ZZcOZlG+o1BpXrSOq2ChfgU6BBy2DXHlMEGTjTRAphi9hJ9a2jp9wt9SPoOi
        XIeND7qTYR8tnCPWjaBkFDVBUprrR5Xu8E2nTkHEPpQJnI0FucO52NlI13y8iXV70oLxZQeK0sIn8
        jmilIPbQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hbnEC-0000KR-UG; Fri, 14 Jun 2019 14:30:52 +0000
Date:   Fri, 14 Jun 2019 07:30:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        util-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Help with reviewing dosfstools patches
Message-ID: <20190614143052.GA21822@infradead.org>
References: <20190614102513.4uwsu2wkigg3pimq@pali>
 <ae5097ee-12af-2807-d48c-4274b4fc856d@metux.net>
 <20190614142534.4obcytnq4v3ejdni@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190614142534.4obcytnq4v3ejdni@pali>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 14, 2019 at 04:25:34PM +0200, Pali Rohár wrote:
> > Does the project already have a maillist ?
> 
> No, there is no mailing list. Basically whole development is on github
> via github pull requests where are also put review comments and where is
> also whole discussion, including bug reports.

That could explain why it is lacking qualified reviewers..
