Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3574D4453D4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 14:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbhKDNaA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 09:30:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:37210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231584AbhKDN37 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 09:29:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85AEC61037;
        Thu,  4 Nov 2021 13:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636032441;
        bh=go96xGjgWXCVhct8CD5/MFzsyGdBF1CHVZDCpFIPKTI=;
        h=Subject:From:To:Cc:Date:From;
        b=W/sUi59ys0O7e4Bvn1fq5xKjAe4kOBX+yP5ZOvSojmPtPjUzwa/adLvAEUu+E7bOb
         yGIhT6L+pnEAQpn3u+uxiLtcuSSYIzUIluMsFVnL1Bb8FRLDhmj6P8OFK68+d6L/Et
         TwXJk1b21rQG4glbBRL8sj1DmVHEV2tTDA4Byo9lB53XjjAKyvIqPf6SwhyLorXggT
         2OkbcFMu21D0qpJIpJLoP7eT4+2wof8zOun2gWquZ9/sQGGeLEI6qsRQ8NszgB43mT
         +wwmId+oAkFawCpZHYGsJ+S3aIS0JPzdwfn8HY2Zn0QfHSQS8Aqp7W/7MHw4q6PsAp
         3A41PGcn4n7oA==
Message-ID: <88ba5bf0c8d5f08b9556499a9891543530471f03.camel@kernel.org>
Subject: FUSE statfs f_fsid field
From:   Jeff Layton <jlayton@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org
Date:   Thu, 04 Nov 2021 09:27:20 -0400
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.0 (3.42.0-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Miklos!

I was looking at an issue [1] with ceph-fuse and noticed that statfs
always reports f_fsid == 0 via statfs. Is there a reason for not letting
the driver fill out that field?

[1]: https://tracker.ceph.com/issues/53045
-- 
Jeff Layton <jlayton@kernel.org>
