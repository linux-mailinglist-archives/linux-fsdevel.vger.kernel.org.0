Return-Path: <linux-fsdevel+bounces-3877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F06BA7F98B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 06:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E1F280E4A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 05:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA1A5692;
	Mon, 27 Nov 2023 05:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3k/sLxR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F557B5;
	Sun, 26 Nov 2023 21:33:41 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b842c1511fso2433259b6e.1;
        Sun, 26 Nov 2023 21:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701063220; x=1701668020; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/FD4q+YVmvTaZu+k/5gCWbJStI77UMa1v3g64Mxy4Ys=;
        b=B3k/sLxRMBKJXzzDNehH5jEI2r2sWNwa4tySiE5TEE68anhUqGWWtGf/LKNgA+XQK5
         F0upnZUi3brC7Eo9CS/p900RTRjRoB070j9FJ/lUWQER67ZcNwUTq6ZhydC/EE3QQanM
         Qy4iSnAMhIsE3HFRFoHA7NbQmlBqlXRmmSyNDk/o4YdQbFe34aBYaeDPuhQ4WRbUuxiD
         G1kgGHv9ciOovAzgozvegFeB43HAYlGbRbXhe823i+R8/4mg4z0mpJ+ALyDBaVb6zLmm
         klZlKX9cvkJ1ZditWKxmg1V9G7ldm7CYM1+LDUuig+iq6hKOtk/TwjycGTnNmJft+ApH
         lMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701063220; x=1701668020;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/FD4q+YVmvTaZu+k/5gCWbJStI77UMa1v3g64Mxy4Ys=;
        b=NFDmQ+CgpwXDPd1F/D1z+0izP9k4DGgIrmJeCnBGhzW4U5N2OCSv1pREy2mc9fhc7E
         ZgO9vExQS/9bHQ8uYhmxvphDTT9d2YzWfMWquccUs6JBN37/qrHKBzNA0gfCXVTBZ4Ov
         tid6iDnglNDA9yg/e8PTsbNn0nknX51unUJmrA6G0QTU9M354ajuyVNjUg2dkjjNW0T7
         YU+0WP8lQnZye8nx1G0P4umQEh3lPojjE6UsGJToXGkA2MO6mE4AlcTSIUSLK9x4V1CZ
         8A3LZiJkvZFF66hwk1CUGw6vfUqmhcDgYcVNBHcUsRZploWERPKNNDGBfQfJCA+BfySP
         L3sA==
X-Gm-Message-State: AOJu0YwE5+1XpQcMBy8YpbRTXhsZ7JhvSqdfhCbXt/2M/39vIvf+oT0D
	HBbWbo48jy+/VAR/E5BuwKiFQlVhAB4=
X-Google-Smtp-Source: AGHT+IGSoWL1BwvvlYVQB0+fIBvqo4vWXxhpCpl+FI65VPMgMMTQ5TA4O1ooaAlFwe+zp8M/3vspEQ==
X-Received: by 2002:a05:6808:2026:b0:3b2:d8cb:8e14 with SMTP id q38-20020a056808202600b003b2d8cb8e14mr14805270oiw.28.1701063219888;
        Sun, 26 Nov 2023 21:33:39 -0800 (PST)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id r13-20020a63fc4d000000b005bd980cca56sm7035577pgk.29.2023.11.26.21.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 21:33:39 -0800 (PST)
Date: Mon, 27 Nov 2023 11:03:35 +0530
Message-Id: <878r6jsqts.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Chandan Babu R <chandan.babu@oracle.com>, Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/13] iomap: move the io_folios field out of struct iomap_ioend
In-Reply-To: <20231126124720.1249310-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

> The io_folios member in struct iomap_ioend counts the number of folios
> added to an ioend.  It is only used at submission time and can thus be
> moved to iomap_writepage_ctx instead.
>

No objections there. We indeed used io_folios to limit the ioend bio
chain lengths and we do this only at the submission time, which is where
wpc is also used for.

Looks good to me. Please feel free to add - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


