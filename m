Return-Path: <linux-fsdevel+bounces-28936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2629716D6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 13:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A601C231B8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 11:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71571B7901;
	Mon,  9 Sep 2024 11:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwV6dHyQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1433B1B3B06;
	Mon,  9 Sep 2024 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725881114; cv=none; b=EBCb/jLQXMVqZhR9DFYVOl7tm6mWjY3xtUsTohv/U9OX4kBws/wrY+EUgSoaKNhP2NXkKcj+XemKYp43e0Gw/YhbB879nmmnoC48MshU/Nftqa++nVh3y8DuUWKo1VUb1RknXBXjSsrFbnRjukEELGGj3KDgWLUQKW8BC4tfXY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725881114; c=relaxed/simple;
	bh=HqGZDyabs5Coh/PiTfcgyDuQNZQ1J9BORTIRtBnBjbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SLMB98dYnTksCV3Gye5p+zKtPHmY25ASd4tzTMAa1YLMkRWgbySstPRwcb4sJKJ6+tTaxHlREhQPXjH1LB+WrfBONn6jrztrd+x9N2DI5JLMiHTksypLwM/OEHFTRWFrA9a1SsdwzicnQF14VHwKioEYETkLWeHFmebvm8YLs1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwV6dHyQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A7FC4CEC5;
	Mon,  9 Sep 2024 11:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725881113;
	bh=HqGZDyabs5Coh/PiTfcgyDuQNZQ1J9BORTIRtBnBjbQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BwV6dHyQhvW44eDRtqePqfV8NXHxYZmvKm6ABQGA/Yyl0DtLpAiPJdyReWr9FUwEc
	 mz4eaiwOB03zRUZaScy/ReKYvleCuwQx1a0i/bdzZjmwesbLtoYe1S5KlvaPCtipJW
	 W8Xgvtg27VxhVuNcbjxBSABQT/j5lu+GPDHKWmwLgNI3gnI7buZqBI9hGgMCE6GsI1
	 mRt12AmNsLQ+h3wYu3stDD6sjbUBmg4Yh12cDMPLZPPLqMgJS98bgOWDmBJsOy2YUG
	 Sjo4MbJjJppW3wEQl9LDp4AcaLIfLS6q78CUtvS0yW0r2dH/TTpgzrz4X0p5ZXGh1D
	 Kb+C3gR0Gmp8A==
Message-ID: <7b46f129-2c9c-40ad-9c47-f3183dc33257@kernel.org>
Date: Mon, 9 Sep 2024 13:25:02 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/17] firmware: qcom: scm: add a call for checking
 wrapped key support
To: Bartosz Golaszewski <brgl@bgdev.pl>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Asutosh Das <quic_asutoshd@quicinc.com>,
 Ritesh Harjani <ritesh.list@gmail.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Eric Biggers <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Gaurav Kashyap <quic_gaurkash@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240906-wrapped-keys-v6-0-d59e61bc0cb4@linaro.org>
 <20240906-wrapped-keys-v6-8-d59e61bc0cb4@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20240906-wrapped-keys-v6-8-d59e61bc0cb4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6.09.2024 8:07 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a helper that allows users to check if wrapped key support is
> available on the platform by checking if the SCM call allowing to
> derive the software secret from a wrapped key is enabled.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

I dearly hope that all firmwares that advertise this call, also
advertise the other necessary ones


Reviewed-by: Konrad Dybcio <konradybcio@kernel.org>

Konrad

