Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09EDC15382F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 19:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgBESdF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 13:33:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41184 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgBESdF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 13:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oi0rYdHcN37UQwcE4W2Lf2qMT1dsNyOX7dXRkMNyxwQ=; b=jgtY6wBeNBXp+deQEJvDcaqhHY
        mnKujaTA42yDgx6r3hij7V5PcRgRIrQoO29YvhVsBrmIw0UNr1ZUUfy4gBdQRVwVaZt/97uNiZ3uC
        8fcXArL6aJLYmjLXZzl0u2zRNQSvF12Pr2M+CjchPCZMY4wDLmoKMgIrLQBZATuMLk3MKrKTOQuH/
        T46NKpO+SOp0P1hT0qR78bPUsglq6eApCQfUM1vwQZna40/vsQLrS4wKuz+f3do46PY4rN5Z9XPL6
        dBoiynAItBC9/UKF8lxcnobQvVl7CIl6yxfON1YeqWKhTMkyVIwyAFFA7dtD4o0VGi6rsaY1XHK68
        s6LxYFKg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izPU1-0001ax-0N; Wed, 05 Feb 2020 18:33:05 +0000
Date:   Wed, 5 Feb 2020 10:33:04 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, hch@infradead.org, dm-devel@redhat.com
Subject: Re: [PATCH 3/5] dm,dax: Add dax zero_page_range operation
Message-ID: <20200205183304.GC26711@infradead.org>
References: <20200203200029.4592-1-vgoyal@redhat.com>
 <20200203200029.4592-4-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203200029.4592-4-vgoyal@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 03, 2020 at 03:00:27PM -0500, Vivek Goyal wrote:
> This patch adds support for dax zero_page_range operation to dm targets.

Any way to share the code with the dax copy iter here?
