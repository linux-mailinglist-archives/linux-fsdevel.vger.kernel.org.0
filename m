Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20DC68195F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 14:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbfHEMfA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 08:35:00 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35786 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfHEMfA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 08:35:00 -0400
Received: by mail-oi1-f193.google.com with SMTP id a127so61833179oii.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Aug 2019 05:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z9PD99q1WDdgGS5wXWSODQaMo35MVtofLkqVSDDdXLQ=;
        b=I/JaR2iDiRCZ/yI9Y2zLDT91+ya1bXj9Itzdv8SmF3ZliSSrvbL40sMU/6lEvQdz53
         rm5njzEM8wXfO+6l2ndCIMlXguZtBN4K23GWCMKj8AzC6IidV5bi7thBAXRPzTOoNBId
         35RHDuQTYmEHrWb2c5vQa/ZdHWGr+MhQZil6UCb8qcjmKlQY2pAePlU0ynZ8yYq3mQyl
         qK6gZxCEw/oyLnt1NaIajkKwNNnSEt7iEHqeHS+6UWmv5nTrUqM49y+w24xGtGWBi+32
         d+qQzFFKc9X8h3JT2T5Gwtbp5ivm6pZnSOYjTRa6pOGfAFEyHnwey5KBxOE1exU2rnwP
         Do+A==
X-Gm-Message-State: APjAAAWCimuU6/VancTYT769Z1gKz0EFJ6PEm1pGmYKlDepZYwEpKCti
        n+rZfiZjRu2Tokdai91gSkFsCuRffTeScH57o39aUA==
X-Google-Smtp-Source: APXvYqx6OeLbcsQmv8sCdKHaXgIbC/F381FJwA38avKdMNNekpIY2ey+NNhV8ycrBsZ4I6P1pLKNKMDH+hgN2NkPuUQ=
X-Received: by 2002:aca:f08a:: with SMTP id o132mr10795741oih.101.1565008499934;
 Mon, 05 Aug 2019 05:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <156444945993.2682261.3926017251626679029.stgit@magnolia> <20190730144839.GA17025@infradead.org>
In-Reply-To: <20190730144839.GA17025@infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 5 Aug 2019 14:34:49 +0200
Message-ID: <CAHc6FU6MX=QgNKU9MOV6z0QB0gcExB26sFKQVyjzvbGJfdC=5Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] iomap: lift the xfs writepage code into iomap
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 30 Jul 2019 at 16:48, Christoph Hellwig <hch@infradead.org> wrote:
> I don't really see the point of the split, but the result looks fine
> to me.

The split made it easier for me to debug the gfs2 side by backing out
the xfs changes.

Thanks,
Andreas
