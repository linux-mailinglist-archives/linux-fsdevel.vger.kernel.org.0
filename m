Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 898FE16895F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 22:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgBUVeF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 16:34:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40410 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726683AbgBUVeF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 16:34:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582320844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AE85XWtWsi6tOM06pCMH0Q1Jbd3MvrBhMiJghYd0Kfk=;
        b=VlwOaUB0mfJElujizLYhorhyxbxXPdOeGMQmKBKxBkj/RkwAuYE8lcHPq5JC7FWsvdSCN6
        gKiI7dBYgDh4PF0MD1FLUHe/aVQFUhfbr7mUgO/X7gijrg/JCgwTXBZJtflWTx6sjzocYZ
        c2bMR59OWT369oPn4SW+ZjuY2AqM4us=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-1XR95YiTMcuW5tTVBdDbzw-1; Fri, 21 Feb 2020 16:33:59 -0500
X-MC-Unique: 1XR95YiTMcuW5tTVBdDbzw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75EFB8018A9;
        Fri, 21 Feb 2020 21:33:58 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D83279053D;
        Fri, 21 Feb 2020 21:33:52 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Christoph Hellwig <hch@infradead.org>,
        device-mapper development <dm-devel@redhat.com>
Subject: Re: [PATCH v5 2/8] drivers/pmem: Allow pmem_clear_poison() to accept arbitrary offset and len
References: <20200218214841.10076-1-vgoyal@redhat.com>
        <20200218214841.10076-3-vgoyal@redhat.com>
        <x49lfoxj622.fsf@segfault.boston.devel.redhat.com>
        <20200220215707.GC10816@redhat.com>
        <x498skv3i5r.fsf@segfault.boston.devel.redhat.com>
        <20200221201759.GF25974@redhat.com>
        <CAPcyv4j3BPGvrhuVaQZgvZ0i+M+i-Ab0BH+mAjR_aZzu4_kidQ@mail.gmail.com>
        <20200221212449.GG25974@redhat.com>
        <CAPcyv4gBHuTDW1M-3W=0nuH1v3whChb8TAK1aA0gosBSKpkqcg@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Fri, 21 Feb 2020 16:33:52 -0500
In-Reply-To: <CAPcyv4gBHuTDW1M-3W=0nuH1v3whChb8TAK1aA0gosBSKpkqcg@mail.gmail.com>
        (Dan Williams's message of "Fri, 21 Feb 2020 13:30:56 -0800")
Message-ID: <x49o8tr1v7j.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> Oh you misunderstood my comment, the "move badblocks to filesystem"
> proposal is long term / down the road thing to consider. In the near
> term this unaligned block zeroing facility is an improvement.

I'm not sure I agree.  I'm going to think about it and get back to you.

-Jeff

