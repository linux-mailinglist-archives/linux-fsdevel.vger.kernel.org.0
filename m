Return-Path: <linux-fsdevel+bounces-1919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DAA7E03BE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 14:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7895281E6F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 13:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99B918621;
	Fri,  3 Nov 2023 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDtmmESV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3214515497
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 13:26:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7A1C433C9
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 13:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699017963;
	bh=omat+vw2xWSo0Q7f0mKoOrR4PqEtsjHJxeygqzPinQc=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=UDtmmESVi2xagxwCqSnzq9YXZ9oqCLDnmdf1QIdbH8RJmxBHhPA205Uaqn/jVbTR2
	 itOnQ6c/2GmZx+rvu1U95MK4SwGRBRBQb6h7xlGeLcAurM6G6owGk1FZ4fyd5I5/Rn
	 aVCjJsFjdgWytiQS44jgTWeJkTYIPEaH8Am63KZAgN/4p4fBDHt7AiyiS9umEz3DLS
	 EHzK0AjbUND36sskE+1o7cWLzd9tK6KtO8wfXG9ZemqVG+qo1I1aJCHHlaxVCS/Bv/
	 d9pibmVOW2klRz6tfQegcNH+vGXTEOWnMB+AnT8//J8IITaId42W7ASJKltPMgqmDy
	 ITHEBlA5UDkXA==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-581edcde26cso1126441eaf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Nov 2023 06:26:03 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz3/TaLmk3suc/sZ+BxPLTB4HOOPhZf4l4NSPF8mR7Ss8XKKjJj
	hNF9qRSzYqR9Vvq1I+QE6i2TFw1w1Qprsgc5R8I=
X-Google-Smtp-Source: AGHT+IHt1XA396wQ04TqaUYlnVF0J7pGILx+wCWdAqG4VJvUTHp9pE3RVylFWGauXcd0zLxgxK1aVkorV71j6ZDgS1o=
X-Received: by 2002:a05:6820:2010:b0:573:4da2:4427 with SMTP id
 by16-20020a056820201000b005734da24427mr23649673oob.7.1699017962927; Fri, 03
 Nov 2023 06:26:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:6f8b:0:b0:4fa:bc5a:10a5 with HTTP; Fri, 3 Nov 2023
 06:26:02 -0700 (PDT)
In-Reply-To: <1891546521.01698986402427.JavaMail.epsvc@epcpadp3>
References: <CGME20231102061033epcas1p2080c6a5b43272c57f85e056f8222ea51@epcas1p2.samsung.com>
 <PUZPR04MB63168C9C4A8EE4321AC575AA81A6A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <1891546521.01698986402427.JavaMail.epsvc@epcpadp3>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 3 Nov 2023 22:26:02 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9RK7Xpcm2jidtWW-kNv13S5QXntj9nrATrDbQB6s4KfA@mail.gmail.com>
Message-ID: <CAKYAXd9RK7Xpcm2jidtWW-kNv13S5QXntj9nrATrDbQB6s4KfA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] exfat: bugfix for timespec update
To: Yuezhang.Mo@sony.com
Cc: Sungjong Seo <sj1557.seo@samsung.com>, linux-fsdevel@vger.kernel.org, Andy.Wu@sony.com, 
	Wataru.Aoyama@sony.com, jlayton@kernel.com
Content-Type: text/plain; charset="UTF-8"

2023-11-03 13:35 GMT+09:00, Sungjong Seo <sj1557.seo@samsung.com>:
>> These patches aim to fix the bugs which caused by commit
>> (4c72a36edd54 exfat: convert to new timestamp accessors).
>>
>> The bugs cause xfstests generic/003 generic/192 generic/221 to fail.
>>
>> Yuezhang Mo (2):
>>   exfat: fix setting uninitialized time to ctime/atime
>>   exfat: fix ctime is not updated
>>
>>  fs/exfat/file.c  | 1 +
>>  fs/exfat/inode.c | 4 ++--
>>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> Looks good. Thanks.
>
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Applied, Thanks for your patch!
>>
>> --
>> 2.25.1
>
>
>

