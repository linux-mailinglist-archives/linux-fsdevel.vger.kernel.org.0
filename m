Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECAEC271AEA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 08:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgIUGey (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 02:34:54 -0400
Received: from verein.lst.de ([213.95.11.211]:38619 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbgIUGey (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 02:34:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 255D968AFE; Mon, 21 Sep 2020 08:34:53 +0200 (CEST)
Date:   Mon, 21 Sep 2020 08:34:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: state cleanups
Message-ID: <20200921063452.GA18349@lst.de>
References: <20200910064244.346913-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910064244.346913-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 10, 2020 at 08:42:38AM +0200, Christoph Hellwig wrote:
> Hi Al,
> 
> a bunch of cleanups to untangle our mess of state related helpers.

ping?
