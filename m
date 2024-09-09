Return-Path: <linux-fsdevel+bounces-28938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C739718B4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 13:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A68A91F23D3A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 11:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7505A1B81DF;
	Mon,  9 Sep 2024 11:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDX195re"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35CB1B6525;
	Mon,  9 Sep 2024 11:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725882707; cv=none; b=vEkYDnVifbrlJFbFQZ3PaHbo/28viZ2VSvC1gpgfGqCvsjQaI7Q3EhrELd5Yx8kN8kYLXyxJ34XIjJGhfa6rTHT6D/1nX5GL2w/CtiGqMw/FqOJjEmIKnINDzi6iSpqTN+i1b7Ar8nK4zIh5F6cdcpzYeNpeJtQi2QhVzY5z2G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725882707; c=relaxed/simple;
	bh=0JyaXQcVV7hV6+TsoSX2pVLz4WSNcsP5lbx3ypUfRNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QxN7GDkbeXhxYJddC2LU7A2X58mncQB30ZEtkaPkWIHkW3WpWaBif7/Tv6/JC9uzV3K++BAfdV3XlftxzJ90tmZK81kYjH35JNxQtNwdKwQaYOoiNMaDbhMUc1T1ZnoTsZXkqtaSUNUZzpbcaKcsjOlhm/C/xAFAWDU1Zt2h1RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDX195re; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DBEC4CEC7;
	Mon,  9 Sep 2024 11:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725882706;
	bh=0JyaXQcVV7hV6+TsoSX2pVLz4WSNcsP5lbx3ypUfRNY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KDX195re/Wb8hzBE3AWZJzabPkZjsDHLVwHFV0SCsWdSvZr8I2P7USdXFqva9tP9Y
	 ukl8bMwjb1RQgdwX1h8f5jCiB7Gl6T+yd7oR3iUcsnjaIR0Z4drxbMybUJO954lZTy
	 NiyiUeAVKW5bG3A9BE/0+X2hlsloMBfpMREn4TK+4OcFXji4mBrky8LZbBp0qsxh6I
	 ecrhqKiN2qd3shH3eqmj97oR8JOWtnv16BPizbTJ73Qom+N94JsxSvNsEJKpD5jiLV
	 p/WtDVZEEGCwezhB9sJ7GKRJf0pks9SdEtDG/LhkffmbzxqP7nby/WGd40bl1l5sI5
	 BufwvRr/w0RCA==
Message-ID: <88e20936-0400-47a3-8909-24e3609e714e@kernel.org>
Date: Mon, 9 Sep 2024 13:51:33 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/17] soc: qcom: ice: add support for hardware wrapped
 keys
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
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Om Prakash Singh <quic_omprsing@quicinc.com>
References: <20240906-wrapped-keys-v6-0-d59e61bc0cb4@linaro.org>
 <20240906-wrapped-keys-v6-10-d59e61bc0cb4@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20240906-wrapped-keys-v6-10-d59e61bc0cb4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6.09.2024 8:07 PM, Bartosz Golaszewski wrote:
> From: Gaurav Kashyap <quic_gaurkash@quicinc.com>
> 
> Now that HWKM support has been added to ICE, extend the ICE driver to
> support hardware wrapped keys programming coming in from the storage
> controllers (UFS and eMMC). This is similar to raw keys where the call is
> forwarded to Trustzone, however we also need to clear and re-enable
> CFGE before and after programming the key.
> 
> Derive software secret support is also added by forwarding the call to
> the corresponding SCM API.
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> Reviewed-by: Om Prakash Singh <quic_omprsing@quicinc.com>
> Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

[...]


> +static int qcom_ice_program_wrapped_key(struct qcom_ice *ice,
> +					const struct blk_crypto_key *key,
> +					u8 data_unit_size, int slot)
> +{
> +	union crypto_cfg cfg;
> +	int hwkm_slot;
> +	int err;
> +
> +	hwkm_slot = translate_hwkm_slot(ice, slot);
> +
> +	memset(&cfg, 0, sizeof(cfg));

union crypto_cfg cfg = { 0 };

?

> +	cfg.dusize = data_unit_size;
> +	cfg.capidx = QCOM_SCM_ICE_CIPHER_AES_256_XTS;
> +	cfg.cfge = 0x80;

Or just partially initialize it at declaration time?

Also, what's 0x80?

Konrad

