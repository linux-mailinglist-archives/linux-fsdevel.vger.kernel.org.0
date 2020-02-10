Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCE48157E92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 16:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgBJPP6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 10:15:58 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40970 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727732AbgBJPP5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 10:15:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581347756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NzDCSfm6cuunZU862JWTkUXnbupHV/su3v7Wgsoqbzs=;
        b=EFXoHGnwLdVScgoU1SgziBN/AV/7t1jKAjDcVyns0renq6kpP96yMHhTnkLx8IJ8GXrR4c
        UsJIQjia3Fsust4T3TFrY7C4vtfycrUid2Ypv7WJU0sLOghndcbisau5MjNcCbP71ZtJ10
        E/9MwvZpaN3Yk6W/dNJ9mYct3G6MkiU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-nKf9PzXeNJCJKCiTeHZpxQ-1; Mon, 10 Feb 2020 10:15:52 -0500
X-MC-Unique: nKf9PzXeNJCJKCiTeHZpxQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECFF7184AEB8;
        Mon, 10 Feb 2020 15:15:49 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 566FC857A9;
        Mon, 10 Feb 2020 15:15:48 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 00/12] Enable per-file/directory DAX operations V3
References: <20200208193445.27421-1-ira.weiny@intel.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Mon, 10 Feb 2020 10:15:47 -0500
In-Reply-To: <20200208193445.27421-1-ira.weiny@intel.com> (ira weiny's message
        of "Sat, 8 Feb 2020 11:34:33 -0800")
Message-ID: <x49imke1nj0.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Ira,

Could you please include documentation patches as part of this series?

Thanks,
Jeff

