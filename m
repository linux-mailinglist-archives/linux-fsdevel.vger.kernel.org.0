Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9601B165FB1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 15:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgBTO1Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 09:27:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33890 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgBTO1Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 09:27:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g5jA0IIPb0t2JWynHb3WLzyKmYpXCbLlmxXB4xY9nOg=; b=Vl3zem4zM7h4jAv/LnITNt11Jn
        /k9RZ2UNsOkHX6TPPwTwQ8YDx2fA/m0jqzxCLMJGZMPNlrnyMDlSPYGXb8no4iXeBCBUxn4x+0POK
        roc7KzQMUy3FcOmmklq8e+CG38Uk/OqJAnA00E09cdXwiJUIp0ocF0LIYKD7UFDShviPuPFQNfmxI
        KxVKhizEK2z+CP+9T5yA0wXSjYPrkg1BSIDRJuhraNaqm6RXzrXa2xYK4MbgBZwB2xpRl5MJSG2uv
        n9gVuLntTX0OoMp9pCXu/FLs1hRaOlwCWZa6QW4IvmYt80skbtYrTNebqGPbR/+9vnrSdeUyF+L9o
        dSdMAl1w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4mnU-0007cs-4F; Thu, 20 Feb 2020 14:27:24 +0000
Date:   Thu, 20 Feb 2020 06:27:24 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 13/21] btrfs: move vairalbes for clustered allocation
 into find_free_extent_ctl
Message-ID: <20200220142724.GA28308@infradead.org>
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-14-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212072048.629856-14-naohiro.aota@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

s/vairalbes/variables/ in the Subject.
