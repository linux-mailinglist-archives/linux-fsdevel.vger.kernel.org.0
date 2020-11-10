Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337002ADE61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 19:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgKJSck (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 13:32:40 -0500
Received: from verein.lst.de ([213.95.11.211]:36964 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgKJSck (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:32:40 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B57BB67373; Tue, 10 Nov 2020 19:32:37 +0100 (CET)
Date:   Tue, 10 Nov 2020 19:32:37 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        fdmanana@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] vfs: separate __sb_start_write into blocking and
 non-blocking helpers
Message-ID: <20201110183237.GA29662@lst.de>
References: <160494580419.772573.9286165021627298770.stgit@magnolia> <160494581731.772573.9685036230289776579.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160494581731.772573.9685036230289776579.stgit@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
