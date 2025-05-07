Return-Path: <linux-fsdevel+bounces-48323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7460CAAD506
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 07:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1315468839
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 05:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75951FCF41;
	Wed,  7 May 2025 05:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sln/kMkK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2F51F460B;
	Wed,  7 May 2025 05:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746595038; cv=none; b=J2sRBA9A840j7iH2JpGc91Tfvfur1cVfIMBNjkUfCLCuG07HR/D7VskAuaH6a3m/yrZEiui72JEVGfQ1S0i0E4emeuIQL6QX8xQw0Ledu1aO2yekcmIwfdkrewV/YoVzK1ZhLjZ7b1184HOxGTYPdjsRb2K9nYPgwXbV7zcJdnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746595038; c=relaxed/simple;
	bh=cCqunWSORWZI8+ZRM7yH3lgkp1MPBBW/HJ0FseqYOb8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gcy51554MUSaxYMQuvzFQ2jWNAZKIWJsgtx1F9YgddVnZR+6CesL6wL0gMqEl/u/eR+2zSVnyKrl0up95zVXoi6Ia4GsH7bXEdPyiSrzFcICrZfiCzTxfE7TOTUzTpjG1p5O45+6h6WK4SYXqm3qd1+YkywfnROEPbcMYlY+H9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sln/kMkK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C458C4CEE9;
	Wed,  7 May 2025 05:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746595037;
	bh=cCqunWSORWZI8+ZRM7yH3lgkp1MPBBW/HJ0FseqYOb8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Sln/kMkKr0PFN3El8naZIIUGb6VymaR5o7tlTa3eS+uGvI8+WyKK5+i0hvDbRO19q
	 bWe3io4L/snelEUkj5uEsHzM3Mx7vv+OwH+4PS0UgAIxdFlw1yOk0a4GOcm5NQKCgP
	 sJ43SwTWU28TtHKU4iTQ/uhsFOSqOHB1hoNm1BVuorBQnJWsPNQeXFXss9FB08IJ0o
	 74qy9f2bU9W4ZQtvrQ7Ix7YfTWUfqZFYAxifumvwdo4ekW0f6E5bNjP/K9zwYNEPqH
	 j2Kg4mYQiWzSSFZ+YH2Q2cUOEAtxi0PC9oHjLiye+QLNgdMUXsRNvRS04m5ziagrzb
	 8Xzis+wf2S+Sw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FC3C369DC;
	Wed,  7 May 2025 05:17:17 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+chenlinxuan.uniontech.com@kernel.org>
Subject: [PATCH 0/2] Add a documentation for FUSE passthrough
Date: Wed, 07 May 2025 13:16:40 +0800
Message-Id: <20250507-fuse-passthrough-doc-v1-0-cc06af79c722@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALjsGmgC/x3MPQqAMAxA4atIZgO1Wv+uIg6lRpvFSmNFEO9uc
 fyG9x4QikwCY/FApIuFw55RlQU4b/eNkJds0EobZVSHaxLCw4qcPoa0eVyCQzNQ5fqm1ratIad
 HpJXvfzvN7/sBdraXHmYAAAA=
X-Change-ID: 20250507-fuse-passthrough-doc-59e1c8432a63
To: Miklos Szeredi <miklos@szeredi.hu>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Chen Linxuan <chenlinxuan@uniontech.com>, 
 Amir Goldstein <amir73il@gmail.com>, 
 Bernd Schubert <bernd.schubert@fastmail.fm>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=856;
 i=chenlinxuan@uniontech.com; h=from:subject:message-id;
 bh=cCqunWSORWZI8+ZRM7yH3lgkp1MPBBW/HJ0FseqYOb8=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBoGuzGnXpdf4wjT49f5TuSBlWPOSu46SsfICKlq
 coRoJzg4HmJAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCaBrsxgAKCRB2HuYUOZmu
 i/yWEADblVtLmhPYCzinPo/tpVOfHQdsnQyolkhroTZGXwKLDUtsCD9uiXMjvhDgmMaOXknb1j+
 /L3hstwT8BKOa3O2LHEUWgXWJiZxUahQYD4q2mTbtnE5DwSR/ykrRGzueUAZ161cOyZM0wbgw61
 8akuzKEmi6rVkNshJ4mx/nYi4yW3YXBLzCioMRX/aCdyMM4BrKg8OTWFSYCHOGxB9LAJs+/XiZP
 j49wZbn+JXjB9/iPB6owXXB8CyniuN+js24AxdtekDzUWxPokzFbatZ53Y4LpojvIzAkPtTUxgP
 EtIYg8uQ8w3QetHf6nMv8lhf1Re1zd9FWpxH4SKCL/GlVApmqXwlS/LZcHaZK5wkGCfYJt3m/9z
 3xO0o6K40CkVPd69Xj+Xoff0/lc5vwQ4H2+vm2j+yS++eCTVC0OVntT7g6bkzs0XRfxmM90suU3
 Peh5EESw1WnURXuvrQwLzjj2Y7FjYPnWqNF9sxXFWQd22xaQ3jD9pGfaBMWwcxUul3kPCPchFmz
 b5z0DVi1aEVPtBizxOmpwdYAbiS/IQNPMLnNHCpZ1q4jqDZWMGdj2s1We43AzFp45mygnDbjJjo
 nuabXUjOuDST2SEp3y7e+lFkdIYYMu6oK9xtq8id8AB6YPgCl35/iJmIDIHLg5y9QlUYBNKDop1
 MgU/7DszgZrhGXg==
X-Developer-Key: i=chenlinxuan@uniontech.com; a=openpgp;
 fpr=D818ACDD385CAE92D4BAC01A6269794D24791D21
X-Endpoint-Received: by B4 Relay for chenlinxuan@uniontech.com/default with
 auth_id=380
X-Original-From: Chen Linxuan <chenlinxuan@uniontech.com>
Reply-To: chenlinxuan@uniontech.com

This series adds a new file,
Documentation/filesystems/fuse-passthrough.rst, which documents why
FUSE passthrough functionality requires CAP_SYS_ADMIN capabilities.

The series also updates the MAINTAINERS file to ensure
scripts/get_maintainer.pl works correctly with FUSE documentation.

Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
Chen Linxuan (2):
      MAINTAINERS: update filter of FUSE documentation
      docs: filesystems: add fuse-passthrough.rst

 Documentation/filesystems/fuse-passthrough.rst | 139 +++++++++++++++++++++++++
 MAINTAINERS                                    |   2 +-
 2 files changed, 140 insertions(+), 1 deletion(-)
---
base-commit: 0d8d44db295ccad20052d6301ef49ff01fb8ae2d
change-id: 20250507-fuse-passthrough-doc-59e1c8432a63

Best regards,
-- 
Chen Linxuan <chenlinxuan@uniontech.com>



