Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10F67133F68
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 11:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgAHKiS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 05:38:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38480 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727338AbgAHKiS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 05:38:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578479897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=McNFtCRyd0uLcr0MpXcFYvBNH/vbYBADBPOFmbrGxlc=;
        b=VAfBLoPaAnIeEqvdrFSG3wHs8yPOYMY+u8xcce4OzlhEXMfFYLIM1xeVJPfsIPj6UWOpQh
        tXYVdkjjqW+koMPe2v978XP6HTJA88qWz+/+HuhGgxY5XXNzQT52swPP5p5lBYxD0jZcsS
        azyyn9L8xG7PruwURzGfKVOhJwk9lTI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-uyBo9BCtNpStiTDHHqITgw-1; Wed, 08 Jan 2020 05:38:14 -0500
X-MC-Unique: uyBo9BCtNpStiTDHHqITgw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79ABA10054E3;
        Wed,  8 Jan 2020 10:38:13 +0000 (UTC)
Received: from 10.255.255.10 (ovpn-204-196.brq.redhat.com [10.40.204.196])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CE4E5D9E1;
        Wed,  8 Jan 2020 10:38:12 +0000 (UTC)
Date:   Wed, 8 Jan 2020 11:38:10 +0100
From:   Karel Zak <kzak@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.35-rc2
Message-ID: <20200108103810.6s45opguridzzp2q@10.255.255.10>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The util-linux release v2.35-rc2 is available at

    https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.35/

Feedback and bug reports, as always, are welcomed.

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

